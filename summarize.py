"""Create comparison tables from retained BenchmarkDotNet full JSON reports."""

import csv
import json
import re
from pathlib import Path

root = Path(__file__).resolve().parent
reports = list((root / "results/full/results").glob("*-report-full.json"))
reports += list((root / "results/capacity/results").glob("*-report-full.json"))
pairs = {}
for report_path in reports:
    report = json.loads(report_path.read_text(encoding="utf-8-sig"))
    for benchmark in report["Benchmarks"]:
        job = re.search(r": (Baseline|Intrinsic)\(", benchmark["DisplayInfo"]).group(1)
        key = (benchmark["Type"], benchmark["Method"], benchmark["Parameters"])
        assert job not in pairs.setdefault(key, {}), f"Duplicate result: {key}, {job}"
        pairs[key][job] = benchmark

rows = []
for (type_name, method, parameters), pair in pairs.items():
    before = pair["Baseline"]["Statistics"]
    after = pair["Intrinsic"]["Statistics"]
    rows.append({
        "Type": type_name, "Method": method, "Parameters": parameters,
        "BaselineMeanNs": before["Mean"],
        "BaselineErrorNs": before["ConfidenceInterval"]["Margin"],
        "BaselineMedianNs": before["Median"],
        "IntrinsicMeanNs": after["Mean"],
        "IntrinsicErrorNs": after["ConfidenceInterval"]["Margin"],
        "IntrinsicMedianNs": after["Median"],
        "ChangePercent": 100 * (after["Mean"] / before["Mean"] - 1),
        "BaselineN": before["N"], "IntrinsicN": after["N"],
    })

assert len(rows) == 28, f"Expected 28 baseline/intrinsic pairs, found {len(rows)}"
with (root / "results/comparison.csv").open("w", encoding="utf-8", newline="") as output:
    writer = csv.DictWriter(output, fieldnames=list(rows[0]))
    writer.writeheader()
    writer.writerows(rows)

lines = ["# Complete comparison", "",
         "Means and errors are in ns/op. Error is half of the 99.9% confidence interval.",
         "Change is the ratio of means minus one; negative means faster. BDN's raw reports",
         "also include its ratio-distribution statistics, medians, and individual measurements.", "",
         "Constant cases marked ~0 are below meaningful timing resolution after folding.", ""]
for group in ("Utf8BufferBenchmarks", "Utf8ConstantBenchmarks", "Utf8VariableBenchmarks"):
    lines += [f"## {group}", "",
              "| Method | Input | Baseline mean ± error | Intrinsic mean ± error | Change |",
              "|---|---|---:|---:|---:|"]
    for row in rows:
        if row["Type"] != group:
            continue
        before = f'{row["BaselineMeanNs"]:.3f} ± {row["BaselineErrorNs"]:.3f}'
        after = f'{row["IntrinsicMeanNs"]:.3f} ± {row["IntrinsicErrorNs"]:.3f}'
        change = f'{row["ChangePercent"]:+.1f}%'
        if group == "Utf8ConstantBenchmarks":
            after, change = "~0 (folded)", "counting eliminated"
        lines.append(f'| {row["Method"]} | {row["Parameters"] or "—"} | {before} | {after} | {change} |')
    lines.append("")

(root / "results/comparison.md").write_text("\n".join(lines) + "\n", encoding="utf-8")
print(f"Wrote {len(rows)} comparisons from {len(reports)} reports.")

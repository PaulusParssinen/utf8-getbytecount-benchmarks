# Measured results: UTF-8 GetByteCount intrinsic

The intrinsic eliminates constant counting work and improves the literal buffer
caller, but the variable buffer caller regresses. The public API wiring needs this
tradeoff considered before landing; these measurements do not support a blanket
claim that nonconstant inputs are unaffected.

## Comparison and method

Measured on 12 October 2026, Windows 11 x64, AMD Ryzen 7 9800X3D.

- Baseline: `45c4eafdc0fc696aa00f776fd326f76b753926b2`.
- Intrinsic: `9b5614ebcc2a8e2894329f535aa43718c1c3a4c9` (`wip`).
- Its commit message was subsequently amended to
  [`638d29eceb3409e4bce68d3a46dab1e2968e2659`](https://github.com/PaulusParssinen/runtime/commit/638d29eceb3409e4bce68d3a46dab1e2968e2659).
  Both commits have the identical source tree
  `4e0cf7a2da7f9a9689ed4138150724ada707c67b`; the measured binaries were not rebuilt.
- Both use locally compiled Release CoreCLR, JIT, and CoreLib, reporting `.NET 12.0.0-dev`.
  Both layouts use the same Release framework libraries. No Checked runtime is timed.
- BenchmarkDotNet 0.15.8; benchmark assembly built with SDK 10.0.204 for `net10.0`.
  The .NET 10 label in job configuration is the build target; the measured runtimes
  are the custom .NET 12 builds, as BDN's process environment confirms.
- Tiered compilation and dynamic PGO enabled; ReadyToRun disabled for both jobs.
  Two launches, six warmups and twelve measured iterations per launch, targeting
  250 ms per iteration. The runtime builds finished before measurements began.
- 36 initial benchmark cases plus 20 capacity-check cases: 28 paired comparisons.
  Input construction is outside timed operations. Stock BDN overhead subtraction
  and outlier filtering are used. Raw measurements and filtered statistics are retained.

## Results worth calling out

Mean time in ns/op; errors below are half of the 99.9% confidence interval.

| Scenario | Baseline | Intrinsic | Change |
|---|---:|---:|---:|
| Size and encode a literal header | 8.630 ± 0.912 | 5.031 ± 0.067 | 41.7% faster |
| Same algorithm, variable header | 7.738 ± 0.201 | 9.911 ± 0.319 | 28.1% slower |
| Variable string, 64 ASCII chars, return count | 5.552 ± 0.094 | 4.697 ± 0.033 | 15.4% faster |
| Variable span, 1024 ASCII chars, return count | 11.455 ± 0.243 | 12.289 ± 0.158 | 7.3% slower |
| Variable span, 1024 ASCII chars, compare to capacity | 11.712 ± 0.357 | 12.270 ± 0.070 | 4.8% slower |

All six constant cases became indistinguishable from empty-method overhead:
empty input, ASCII, Unicode span, malformed UTF-16, initialized readonly string,
and 256 CJK characters producing 768 UTF-8 bytes. Their baseline means ranged
from 3.48 to 38.34 ns. The near-zero numbers mean eliminated work, not accurate
sub-picosecond timing.

Variable results depend on input and caller shape. Many improved; the header
caller and long-ASCII span cases regressed. Capacity comparisons were included
to exercise work after the count rather than only returning it. The captured
FullOpts assembly uses ordinary calls in both direct-return and comparison cases;
the improvements should not simply be attributed to tail calls.

Both header cases allocate zero managed bytes in both runtimes. BDN flagged
some ASCII64 distributions as bimodal; small differences deserve caution. The
literal-header baseline also has noticeably more variance, so its median is
8.145 ns versus 5.006 ns with the intrinsic (38.5% faster by medians).

The full matrix, errors, medians, and sample counts are in
[comparison.md](results/comparison.md) and [comparison.csv](results/comparison.csv).
Original BDN Markdown, CSV, full JSON, and logs are under `results/full` and
`results/capacity`. Runtime binary hashes and assembly hashes are in
[environment.json](results/environment.json).

## A caller where it matters

The benchmark sizes a temporary UTF-8 buffer for a 32-character header, using
the customary stack/heap threshold, then encodes and consumes bytes:

```csharp
const string Header = "Content-Type: application/json\r\n";
int byteCount = Encoding.UTF8.GetByteCount(Header);
Span<byte> bytes = byteCount <= 64 ? stackalloc byte[byteCount] : new byte[byteCount];
int written = Encoding.UTF8.GetBytes(Header, bytes);
return written + bytes[0] + bytes[written - 1];
```

Both runtimes produce checksum `109`. The literal method's FullOpts assembly
shrinks from **466 to 351 bytes**. The UTF-16 scan, byte-count adjustment,
count-fallback call, and count-overflow handling disappear. The count becomes
`mov esi, 32`. UTF-8 encoding still executes.

The allocation guard and dynamic stackalloc sequence remain in this codegen:
the dump still contains `cmp esi, 64` after loading 32. Thus this demonstrates
elimination of counting, not complete propagation into every dependent
allocation optimization.

See [the complete assembly diff](asm/header.diff), [baseline](asm/baseline.asm),
and [intrinsic](asm/intrinsic.asm). Normalized files replace process addresses
and stack cookies with `0xRELOC` and remove byte-offset annotations; instructions
and branch labels are otherwise retained. Original dumps are included.

Assembly was captured from the runtime's own JIT with tiering and ReadyToRun
disabled, to obtain deterministic FullOpts output. The timings above use tiered
PGO, so this is a code-generation demonstration rather than an exact dump of each
timed Tier1 compilation. BenchmarkDotNet's disassembler produced no code for
these CoreRun builds. Additional variable-caller dumps are in `asm/variable`.

## Reproduce and share

See [README.md](README.md), `run-comparison.ps1`, and `capture-asm.ps1`.
`summarize.py` regenerates the combined tables from the saved full JSON reports.
The initial run was `--filter '*'` before adding the two capacity-check methods;
the supplementary run was `--filter '*Fits*'`. No runtime implementation was
changed while measuring. The later demo-only additions and consolidation into
`Program.cs` do not change timed benchmark bodies. The consolidated source builds
and passes the assembly demonstration under both measured runtimes.

The shareable archive includes source, scripts, reports, and assembly dumps.
It excludes `.local`, `bin`, and `obj`, including the local runtime snapshots.

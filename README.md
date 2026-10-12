# UTF-8 GetByteCount intrinsic benchmarks

Standalone BenchmarkDotNet 0.15.8 benchmarks targeting .NET 10. The same compiled
benchmark assembly can run on two compatible, locally built CoreCLR runtimes.
No runtime repository source files or test infrastructure are required by this project.

All benchmark cases, comparison jobs, and the assembly demonstration are in
[Program.cs](Program.cs). Measurements and the benefits and regressions observed
are documented in [RESULTS.md](RESULTS.md).

The proposed runtime change addresses
[dotnet/runtime#102246](https://github.com/dotnet/runtime/issues/102246).
The implementation is on
[PaulusParssinen/runtime:intrinsify-utf8-getbytecount](https://github.com/PaulusParssinen/runtime/tree/intrinsify-utf8-getbytecount).
This repository supports discussion of the tradeoff; the measurements do not
establish a benefit in an existing BCL serialization path.

## Run

```powershell
dotnet run -c Release -- --filter '*'
```

Or use `run-comparison.ps1 -BaselineCoreRun <path> -IntrinsicCoreRun <path>`.

To compare two Release Core_Root layouts, set paths to the actual executables:

```powershell
$env:UTF8_BASELINE_CORERUN = 'C:\runtimes\baseline\corerun.exe'
$env:UTF8_PATCHED_CORERUN = 'C:\runtimes\intrinsic\corerun.exe'
$env:UTF8_DOTNET_CLI = 'C:\Program Files\dotnet\dotnet.exe'
dotnet run -c Release -- --filter '*'
```

BenchmarkDotNet copies each runtime before running it. It does not modify your
original runtime layouts. Both comparison jobs use tiered compilation and dynamic
PGO, disable ReadyToRun, and collect two launches, six warmup iterations, and twelve
measurement iterations per launch, targeting 250 ms per iteration.

- `Utf8ConstantBenchmarks` covers empty, ASCII, Unicode, replacement fallback,
  initialized readonly strings, and output exceeding 256 bytes.
- `Utf8VariableBenchmarks` covers string and span overloads with mutable instance
  fields, short and long ASCII, Unicode, and malformed UTF-16. Input construction
  happens outside the timed operation. `FitsString` and `FitsSpan` compare the
  result to a capacity, preventing a tail call to the count helper. The direct-return
  cases can permit a tail call and therefore measure a different caller shape.
- `Utf8BufferBenchmarks` sizes a buffer, chooses stack or heap allocation at a
  64-byte threshold, encodes a header, and consumes encoded bytes. It also runs
  the same algorithm on an instance-field string that cannot fold.

The count-only constant cases can become essentially empty after folding. Values
near zero should be interpreted as eliminated counting work, not literal timing
accuracy at that scale. The buffer benchmarks provide a caller-level comparison.

## JIT assembly demonstration

Build once, then execute the same DLL under each CoreRun. For a deterministic
fully optimized comparison, temporarily set:

```powershell
$env:DOTNET_TieredCompilation = '0'
$env:DOTNET_ReadyToRun = '0'
$env:DOTNET_JitDisasm = 'Utf8BufferBenchmarks:EncodeLiteralHeader'
$env:DOTNET_JitDiffableDisasm = '1'
$env:DOTNET_JitStdOutFile = "$PWD\baseline.asm"
& $env:UTF8_BASELINE_CORERUN "$PWD\bin\Release\net10.0\Utf8GetByteCountBenchmarks.dll" --asm-demo
$env:DOTNET_JitStdOutFile = "$PWD\intrinsic.asm"
& $env:UTF8_PATCHED_CORERUN "$PWD\bin\Release\net10.0\Utf8GetByteCountBenchmarks.dll" --asm-demo
```

Unset these diagnostic environment variables before benchmarking. Alternatively,
`capture-asm.ps1 -BaselineCoreRun <path> -IntrinsicCoreRun <path>` builds the project,
captures both JIT dumps, normalizes process addresses and stack cookies, exports
`asm/header.diff`, and restores the diagnostic environment variables. This uses
the runtime's own JIT diagnostics; BenchmarkDotNet's disassembler returned no code
with these custom CoreRun builds, so the retained comparison comes from the JIT.

Local build logs and runtime snapshots belong in `.local/`; they are excluded from
the shareable source archive. Results and assembly comparisons are retained separately.

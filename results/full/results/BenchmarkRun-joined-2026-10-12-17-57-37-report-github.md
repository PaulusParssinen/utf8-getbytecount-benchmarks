```

BenchmarkDotNet v0.15.8, Windows 11 (10.0.26100.9457/24H2/2024Update/HudsonValley)
AMD Ryzen 7 9800X3D 4.70GHz, 1 CPU, 16 logical and 8 physical cores
.NET SDK 10.0.204
  [Host]    : .NET 10.0.12 (10.0.12, 10.0.1226.42308), X64 RyuJIT x86-64-v4
  Baseline  : .NET 12.0.0 (12.0.0-dev, 42.42.42.42424), X64 RyuJIT x86-64-v4
  Intrinsic : .NET 12.0.0 (12.0.0-dev, 42.42.42.42424), X64 RyuJIT x86-64-v4

EnvironmentVariables=DOTNET_TieredCompilation=1,DOTNET_TieredPGO=1,DOTNET_ReadyToRun=0  Runtime=.NET 10.0  IterationCount=12  
IterationTime=250ms  LaunchCount=2  WarmupCount=6  

```
| Type                   | Method                    | Job       | Toolchain | Input     | Mean       | Error     | StdDev    | Median     | Ratio | RatioSD | Allocated | Alloc Ratio |
|----------------------- |-------------------------- |---------- |---------- |---------- |-----------:|----------:|----------:|-----------:|------:|--------:|----------:|------------:|
| **Utf8BufferBenchmarks**   | **EncodeLiteralHeader**       | **Baseline**  | **Baseline**  | **?**         |  **8.6300 ns** | **0.9124 ns** | **1.0508 ns** |  **8.1452 ns** |  **1.01** |    **0.15** |         **-** |          **NA** |
| Utf8BufferBenchmarks   | EncodeLiteralHeader       | Intrinsic | Intrinsic | ?         |  5.0310 ns | 0.0669 ns | 0.0846 ns |  5.0062 ns |  0.59 |    0.06 |         - |          NA |
|                        |                           |           |           |           |            |           |           |            |       |         |           |             |
| Utf8ConstantBenchmarks | Empty                     | Baseline  | Baseline  | ?         |  3.4804 ns | 0.0410 ns | 0.0488 ns |  3.4599 ns | 1.000 |    0.02 |        NA |          NA |
| Utf8ConstantBenchmarks | Empty                     | Intrinsic | Intrinsic | ?         |  0.0017 ns | 0.0021 ns | 0.0025 ns |  0.0006 ns | 0.000 |    0.00 |        NA |          NA |
|                        |                           |           |           |           |            |           |           |            |       |         |           |             |
| Utf8BufferBenchmarks   | EncodeVariableHeader      | Baseline  | Baseline  | ?         |  7.7383 ns | 0.2010 ns | 0.2234 ns |  7.6727 ns |  1.00 |    0.04 |         - |          NA |
| Utf8BufferBenchmarks   | EncodeVariableHeader      | Intrinsic | Intrinsic | ?         |  9.9112 ns | 0.3189 ns | 0.3916 ns |  9.7212 ns |  1.28 |    0.06 |         - |          NA |
|                        |                           |           |           |           |            |           |           |            |       |         |           |             |
| Utf8ConstantBenchmarks | Ascii                     | Baseline  | Baseline  | ?         |  3.6813 ns | 0.0040 ns | 0.0047 ns |  3.6820 ns | 1.000 |    0.00 |        NA |          NA |
| Utf8ConstantBenchmarks | Ascii                     | Intrinsic | Intrinsic | ?         |  0.0076 ns | 0.0115 ns | 0.0137 ns |  0.0017 ns | 0.002 |    0.00 |        NA |          NA |
|                        |                           |           |           |           |            |           |           |            |       |         |           |             |
| Utf8ConstantBenchmarks | UnicodeSpan               | Baseline  | Baseline  | ?         |  5.8218 ns | 0.0638 ns | 0.0709 ns |  5.8042 ns | 1.000 |    0.02 |        NA |          NA |
| Utf8ConstantBenchmarks | UnicodeSpan               | Intrinsic | Intrinsic | ?         |  0.0007 ns | 0.0016 ns | 0.0018 ns |  0.0000 ns | 0.000 |    0.00 |        NA |          NA |
|                        |                           |           |           |           |            |           |           |            |       |         |           |             |
| Utf8ConstantBenchmarks | Malformed                 | Baseline  | Baseline  | ?         | 38.3369 ns | 0.8384 ns | 0.9655 ns | 37.9987 ns | 1.001 |    0.03 |        NA |          NA |
| Utf8ConstantBenchmarks | Malformed                 | Intrinsic | Intrinsic | ?         |  0.0269 ns | 0.0326 ns | 0.0389 ns |  0.0093 ns | 0.001 |    0.00 |        NA |          NA |
|                        |                           |           |           |           |            |           |           |            |       |         |           |             |
| Utf8ConstantBenchmarks | InitializedReadonlyString | Baseline  | Baseline  | ?         |  5.7925 ns | 0.0283 ns | 0.0337 ns |  5.7902 ns | 1.000 |    0.01 |        NA |          NA |
| Utf8ConstantBenchmarks | InitializedReadonlyString | Intrinsic | Intrinsic | ?         |  0.0033 ns | 0.0043 ns | 0.0053 ns |  0.0010 ns | 0.001 |    0.00 |        NA |          NA |
|                        |                           |           |           |           |            |           |           |            |       |         |           |             |
| Utf8ConstantBenchmarks | LargeEncodedOutput        | Baseline  | Baseline  | ?         | 25.6351 ns | 0.6066 ns | 0.7671 ns | 25.3133 ns | 1.001 |    0.04 |        NA |          NA |
| Utf8ConstantBenchmarks | LargeEncodedOutput        | Intrinsic | Intrinsic | ?         |  0.0392 ns | 0.0606 ns | 0.0766 ns |  0.0026 ns | 0.002 |    0.00 |        NA |          NA |
|                        |                           |           |           |           |            |           |           |            |       |         |           |             |
| **Utf8VariableBenchmarks** | **String**                    | **Baseline**  | **Baseline**  | **Ascii5**    |  **4.1290 ns** | **0.1243 ns** | **0.1432 ns** |  **4.0757 ns** |  **1.00** |    **0.05** |        **NA** |          **NA** |
| Utf8VariableBenchmarks | String                    | Intrinsic | Intrinsic | Ascii5    |  3.6631 ns | 0.0222 ns | 0.0255 ns |  3.6531 ns |  0.89 |    0.03 |        NA |          NA |
|                        |                           |           |           |           |            |           |           |            |       |         |           |             |
| Utf8VariableBenchmarks | Span                      | Baseline  | Baseline  | Ascii5    |  4.0261 ns | 0.1575 ns | 0.1751 ns |  4.0225 ns |  1.00 |    0.06 |        NA |          NA |
| Utf8VariableBenchmarks | Span                      | Intrinsic | Intrinsic | Ascii5    |  3.9778 ns | 0.0226 ns | 0.0278 ns |  3.9781 ns |  0.99 |    0.04 |        NA |          NA |
|                        |                           |           |           |           |            |           |           |            |       |         |           |             |
| **Utf8VariableBenchmarks** | **String**                    | **Baseline**  | **Baseline**  | **Ascii64**   |  **5.5517 ns** | **0.0939 ns** | **0.1118 ns** |  **5.5085 ns** |  **1.00** |    **0.03** |        **NA** |          **NA** |
| Utf8VariableBenchmarks | String                    | Intrinsic | Intrinsic | Ascii64   |  4.6970 ns | 0.0328 ns | 0.0378 ns |  4.6881 ns |  0.85 |    0.02 |        NA |          NA |
|                        |                           |           |           |           |            |           |           |            |       |         |           |             |
| Utf8VariableBenchmarks | Span                      | Baseline  | Baseline  | Ascii64   |  5.8284 ns | 0.4428 ns | 0.5099 ns |  5.7398 ns |  1.01 |    0.12 |        NA |          NA |
| Utf8VariableBenchmarks | Span                      | Intrinsic | Intrinsic | Ascii64   |  4.8120 ns | 0.0110 ns | 0.0130 ns |  4.8088 ns |  0.83 |    0.07 |        NA |          NA |
|                        |                           |           |           |           |            |           |           |            |       |         |           |             |
| **Utf8VariableBenchmarks** | **String**                    | **Baseline**  | **Baseline**  | **Ascii1024** | **11.7556 ns** | **0.2384 ns** | **0.3015 ns** | **11.6212 ns** |  **1.00** |    **0.03** |        **NA** |          **NA** |
| Utf8VariableBenchmarks | String                    | Intrinsic | Intrinsic | Ascii1024 | 11.2610 ns | 0.0570 ns | 0.0741 ns | 11.2234 ns |  0.96 |    0.02 |        NA |          NA |
|                        |                           |           |           |           |            |           |           |            |       |         |           |             |
| Utf8VariableBenchmarks | Span                      | Baseline  | Baseline  | Ascii1024 | 11.4550 ns | 0.2426 ns | 0.2793 ns | 11.3681 ns |  1.00 |    0.03 |        NA |          NA |
| Utf8VariableBenchmarks | Span                      | Intrinsic | Intrinsic | Ascii1024 | 12.2892 ns | 0.1579 ns | 0.1997 ns | 12.1857 ns |  1.07 |    0.03 |        NA |          NA |
|                        |                           |           |           |           |            |           |           |            |       |         |           |             |
| **Utf8VariableBenchmarks** | **String**                    | **Baseline**  | **Baseline**  | **Unicode**   |  **6.0737 ns** | **0.1485 ns** | **0.1768 ns** |  **6.0059 ns** |  **1.00** |    **0.04** |        **NA** |          **NA** |
| Utf8VariableBenchmarks | String                    | Intrinsic | Intrinsic | Unicode   |  5.7689 ns | 0.0819 ns | 0.0975 ns |  5.7503 ns |  0.95 |    0.03 |        NA |          NA |
|                        |                           |           |           |           |            |           |           |            |       |         |           |             |
| Utf8VariableBenchmarks | Span                      | Baseline  | Baseline  | Unicode   |  5.9803 ns | 0.0316 ns | 0.0376 ns |  5.9694 ns |  1.00 |    0.01 |        NA |          NA |
| Utf8VariableBenchmarks | Span                      | Intrinsic | Intrinsic | Unicode   |  5.8426 ns | 0.0877 ns | 0.1044 ns |  5.8260 ns |  0.98 |    0.02 |        NA |          NA |
|                        |                           |           |           |           |            |           |           |            |       |         |           |             |
| **Utf8VariableBenchmarks** | **String**                    | **Baseline**  | **Baseline**  | **Malformed** | **37.1089 ns** | **0.4286 ns** | **0.5264 ns** | **37.1053 ns** |  **1.00** |    **0.02** |        **NA** |          **NA** |
| Utf8VariableBenchmarks | String                    | Intrinsic | Intrinsic | Malformed | 36.6816 ns | 0.4929 ns | 0.5676 ns | 36.5595 ns |  0.99 |    0.02 |        NA |          NA |
|                        |                           |           |           |           |            |           |           |            |       |         |           |             |
| Utf8VariableBenchmarks | Span                      | Baseline  | Baseline  | Malformed | 36.9773 ns | 0.2254 ns | 0.2684 ns | 36.9115 ns |  1.00 |    0.01 |        NA |          NA |
| Utf8VariableBenchmarks | Span                      | Intrinsic | Intrinsic | Malformed | 36.3245 ns | 0.3211 ns | 0.3822 ns | 36.3415 ns |  0.98 |    0.01 |        NA |          NA |

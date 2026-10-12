# Complete comparison

Means and errors are in ns/op. Error is half of the 99.9% confidence interval.
Change is the ratio of means minus one; negative means faster. BDN's raw reports
also include its ratio-distribution statistics, medians, and individual measurements.

Constant cases marked ~0 are below meaningful timing resolution after folding.

## Utf8BufferBenchmarks

| Method | Input | Baseline mean ± error | Intrinsic mean ± error | Change |
|---|---|---:|---:|---:|
| EncodeLiteralHeader | — | 8.630 ± 0.912 | 5.031 ± 0.067 | -41.7% |
| EncodeVariableHeader | — | 7.738 ± 0.201 | 9.911 ± 0.319 | +28.1% |

## Utf8ConstantBenchmarks

| Method | Input | Baseline mean ± error | Intrinsic mean ± error | Change |
|---|---|---:|---:|---:|
| Empty | — | 3.480 ± 0.041 | ~0 (folded) | counting eliminated |
| Ascii | — | 3.681 ± 0.004 | ~0 (folded) | counting eliminated |
| UnicodeSpan | — | 5.822 ± 0.064 | ~0 (folded) | counting eliminated |
| Malformed | — | 38.337 ± 0.838 | ~0 (folded) | counting eliminated |
| InitializedReadonlyString | — | 5.792 ± 0.028 | ~0 (folded) | counting eliminated |
| LargeEncodedOutput | — | 25.635 ± 0.607 | ~0 (folded) | counting eliminated |

## Utf8VariableBenchmarks

| Method | Input | Baseline mean ± error | Intrinsic mean ± error | Change |
|---|---|---:|---:|---:|
| String | Input=Ascii5 | 4.129 ± 0.124 | 3.663 ± 0.022 | -11.3% |
| Span | Input=Ascii5 | 4.026 ± 0.158 | 3.978 ± 0.023 | -1.2% |
| String | Input=Ascii64 | 5.552 ± 0.094 | 4.697 ± 0.033 | -15.4% |
| Span | Input=Ascii64 | 5.828 ± 0.443 | 4.812 ± 0.011 | -17.4% |
| String | Input=Ascii1024 | 11.756 ± 0.238 | 11.261 ± 0.057 | -4.2% |
| Span | Input=Ascii1024 | 11.455 ± 0.243 | 12.289 ± 0.158 | +7.3% |
| String | Input=Unicode | 6.074 ± 0.149 | 5.769 ± 0.082 | -5.0% |
| Span | Input=Unicode | 5.980 ± 0.032 | 5.843 ± 0.088 | -2.3% |
| String | Input=Malformed | 37.109 ± 0.429 | 36.682 ± 0.493 | -1.2% |
| Span | Input=Malformed | 36.977 ± 0.225 | 36.325 ± 0.321 | -1.8% |
| FitsString | Input=Ascii5 | 4.043 ± 0.008 | 3.675 ± 0.043 | -9.1% |
| FitsSpan | Input=Ascii5 | 4.035 ± 0.011 | 3.857 ± 0.013 | -4.4% |
| FitsString | Input=Ascii64 | 5.592 ± 0.016 | 5.040 ± 0.277 | -9.9% |
| FitsSpan | Input=Ascii64 | 5.880 ± 0.293 | 4.854 ± 0.014 | -17.4% |
| FitsString | Input=Ascii1024 | 11.676 ± 0.134 | 11.448 ± 0.042 | -2.0% |
| FitsSpan | Input=Ascii1024 | 11.712 ± 0.357 | 12.270 ± 0.070 | +4.8% |
| FitsString | Input=Unicode | 5.979 ± 0.018 | 5.881 ± 0.068 | -1.6% |
| FitsSpan | Input=Unicode | 5.962 ± 0.013 | 6.000 ± 0.039 | +0.6% |
| FitsString | Input=Malformed | 37.941 ± 0.534 | 36.809 ± 0.197 | -3.0% |
| FitsSpan | Input=Malformed | 37.595 ± 0.230 | 36.972 ± 0.582 | -1.7% |


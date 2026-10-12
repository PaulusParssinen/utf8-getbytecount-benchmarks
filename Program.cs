using System.Runtime.CompilerServices;
using System.Text;
using BenchmarkDotNet.Attributes;
using BenchmarkDotNet.Configs;
using BenchmarkDotNet.Environments;
using BenchmarkDotNet.Exporters.Json;
using BenchmarkDotNet.Jobs;
using BenchmarkDotNet.Running;
using BenchmarkDotNet.Toolchains.CoreRun;
using Perfolizer.Horology;

if (args.Contains("--asm-demo"))
{
    Console.WriteLine($"CoreLib: {typeof(object).Assembly.Location}");
    Console.WriteLine($"Runtime: {Environment.Version}");
    var benchmark = new Utf8BufferBenchmarks();
    benchmark.Setup();
    int literal = benchmark.EncodeLiteralHeader();
    int variable = benchmark.EncodeVariableHeader();
    if (literal != variable)
        throw new InvalidOperationException($"Output mismatch: {literal} != {variable}");
    Console.WriteLine($"Encoded header checksum: {literal}");
    var counting = new Utf8VariableBenchmarks { Input = InputKind.Ascii64 };
    counting.Setup();
    if (counting.String() != 64 || counting.Span() != 64 || !counting.FitsString() || !counting.FitsSpan())
        throw new InvalidOperationException("Variable count validation failed.");
    return;
}

var job = Job.Default
    .WithLaunchCount(2)
    .WithWarmupCount(6)
    .WithIterationCount(12)
    .WithIterationTime(TimeInterval.FromMilliseconds(250))
    .WithEnvironmentVariable("DOTNET_TieredCompilation", "1")
    .WithEnvironmentVariable("DOTNET_TieredPGO", "1")
    .WithEnvironmentVariable("DOTNET_ReadyToRun", "0");

var config = ManualConfig.Create(DefaultConfig.Instance)
    .WithOptions(ConfigOptions.JoinSummary)
    .AddExporter(JsonExporter.Full);

var runtime = CoreRuntime.Core10_0;

string? baseline = Environment.GetEnvironmentVariable("UTF8_BASELINE_CORERUN");
string? patched = Environment.GetEnvironmentVariable("UTF8_PATCHED_CORERUN");
string? cli = Environment.GetEnvironmentVariable("UTF8_DOTNET_CLI");

if (baseline is null && patched is null)
{
    config.AddJob(job.WithRuntime(runtime).WithId("Installed"));
}
else
{
    if (baseline is null || patched is null)
        throw new ArgumentException("Set both UTF8_BASELINE_CORERUN and UTF8_PATCHED_CORERUN.");

    config.AddJob(CreateJob(baseline, "Baseline").AsBaseline());
    config.AddJob(CreateJob(patched, "Intrinsic"));
}

BenchmarkSwitcher.FromAssembly(typeof(Program).Assembly).Run(args, config);

Job CreateJob(string path, string name) => job
    .WithRuntime(runtime)
    .WithToolchain(new CoreRunToolchain(
        new FileInfo(path),
        createCopy: true,
        targetFrameworkMoniker: "net10.0",
        customDotNetCliPath: cli is null ? null : new FileInfo(cli),
        displayName: name))
    .WithId(name);

public class Utf8ConstantBenchmarks
{
    private const string Cjk4 = "鉄鉄鉄鉄";
    private const string Cjk16 = Cjk4 + Cjk4 + Cjk4 + Cjk4;
    private const string Cjk64 = Cjk16 + Cjk16 + Cjk16 + Cjk16;
    private const string Cjk256 = Cjk64 + Cjk64 + Cjk64 + Cjk64;
    private static readonly string s_text = "Aé鉄😀";

    [GlobalSetup]
    public void Setup() => GC.KeepAlive(s_text);

    [Benchmark]
    [MethodImpl(MethodImplOptions.NoInlining)]
    public int Empty() => Encoding.UTF8.GetByteCount("");

    [Benchmark]
    [MethodImpl(MethodImplOptions.NoInlining)]
    public int Ascii() => Encoding.UTF8.GetByteCount("hello");

    [Benchmark]
    [MethodImpl(MethodImplOptions.NoInlining)]
    public int UnicodeSpan() => Encoding.UTF8.GetByteCount("Aé鉄😀".AsSpan());

    [Benchmark]
    [MethodImpl(MethodImplOptions.NoInlining)]
    public int Malformed() => Encoding.UTF8.GetByteCount("\uD800x\uDC00\uD800\uD800");

    [Benchmark]
    [MethodImpl(MethodImplOptions.NoInlining)]
    public int InitializedReadonlyString() => Encoding.UTF8.GetByteCount(s_text);

    [Benchmark]
    [MethodImpl(MethodImplOptions.NoInlining)]
    public int LargeEncodedOutput() => Encoding.UTF8.GetByteCount(Cjk256);
}

public enum InputKind
{
    Ascii5,
    Ascii64,
    Ascii1024,
    Unicode,
    Malformed
}

public class Utf8VariableBenchmarks
{
    private string _text = null!;

    [ParamsAllValues]
    public InputKind Input { get; set; }

    [GlobalSetup]
    public void Setup()
    {
        _text = Input switch
        {
            InputKind.Ascii5 => new string('a', 5),
            InputKind.Ascii64 => new string('a', 64),
            InputKind.Ascii1024 => new string('a', 1024),
            InputKind.Unicode => "Aé鉄😀",
            InputKind.Malformed => "\uD800x\uDC00\uD800\uD800",
            _ => throw new ArgumentOutOfRangeException()
        };
    }

    [Benchmark]
    [MethodImpl(MethodImplOptions.NoInlining)]
    public int String() => Encoding.UTF8.GetByteCount(_text);

    [Benchmark]
    [MethodImpl(MethodImplOptions.NoInlining)]
    public int Span() => Encoding.UTF8.GetByteCount(_text.AsSpan());

    [Benchmark]
    [MethodImpl(MethodImplOptions.NoInlining)]
    public bool FitsString() => Encoding.UTF8.GetByteCount(_text) <= 128;

    [Benchmark]
    [MethodImpl(MethodImplOptions.NoInlining)]
    public bool FitsSpan() => Encoding.UTF8.GetByteCount(_text.AsSpan()) <= 128;
}


[MemoryDiagnoser]
public class Utf8BufferBenchmarks
{
    private const string Header = "Content-Type: application/json\r\n";
    private string _header = null!;

    [GlobalSetup]
    public void Setup() => _header = new string(Header.AsSpan());

    [Benchmark]
    [MethodImpl(MethodImplOptions.NoInlining)]
    public int EncodeLiteralHeader()
    {
        int byteCount = Encoding.UTF8.GetByteCount(Header);
        Span<byte> bytes = byteCount <= 64 ? stackalloc byte[byteCount] : new byte[byteCount];
        int written = Encoding.UTF8.GetBytes(Header, bytes);
        // Read the encoded data to keep the writes observable in this microbenchmark.
        return written + bytes[0] + bytes[written - 1];
    }

    [Benchmark]
    [MethodImpl(MethodImplOptions.NoInlining)]
    public int EncodeVariableHeader()
    {
        string header = _header;
        int byteCount = Encoding.UTF8.GetByteCount(header);
        Span<byte> bytes = byteCount <= 64 ? stackalloc byte[byteCount] : new byte[byteCount];
        int written = Encoding.UTF8.GetBytes(header, bytes);
        return written + bytes[0] + bytes[written - 1];
    }
}

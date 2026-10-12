param(
    [Parameter(Mandatory)] [string] $BaselineCoreRun,
    [Parameter(Mandatory)] [string] $IntrinsicCoreRun,
    [string] $DotNetCli = 'dotnet',
    [string] $MethodFilter = 'Utf8BufferBenchmarks:EncodeLiteralHeader',
    [string] $OutputDirectory = 'asm'
)

$ErrorActionPreference = 'Stop'
$variableNames = @(
    'DOTNET_TieredCompilation', 'DOTNET_ReadyToRun', 'DOTNET_JitDisasm',
    'DOTNET_JitDiffableDisasm', 'DOTNET_JitStdOutFile'
)
$previous = @{}
foreach ($name in $variableNames) {
    $previous[$name] = [Environment]::GetEnvironmentVariable($name, 'Process')
}

Push-Location $PSScriptRoot
try {
    & $DotNetCli build -c Release
    if ($LASTEXITCODE -ne 0) { throw 'Benchmark build failed.' }
    New-Item -ItemType Directory -Path $OutputDirectory -Force | Out-Null
    $env:DOTNET_TieredCompilation = '0'
    $env:DOTNET_ReadyToRun = '0'
    $env:DOTNET_JitDisasm = $MethodFilter
    $env:DOTNET_JitDiffableDisasm = '1'

    foreach ($runtime in @(@('baseline', $BaselineCoreRun), @('intrinsic', $IntrinsicCoreRun))) {
        $env:DOTNET_JitStdOutFile = Join-Path (Join-Path $PSScriptRoot $OutputDirectory) "$($runtime[0]).asm"
        Set-Content -LiteralPath $env:DOTNET_JitStdOutFile -Value '' -NoNewline -Encoding utf8
        & $runtime[1] "$PSScriptRoot/bin/Release/net10.0/Utf8GetByteCountBenchmarks.dll" --asm-demo
        if ($LASTEXITCODE -ne 0) { throw "Assembly demonstration failed: $($runtime[0])" }
        $text = Get-Content -LiteralPath $env:DOTNET_JitStdOutFile -Raw
        # Normalize process addresses and stack cookies; retain original dumps as well.
        $text = $text -replace '0x[0-9A-Fa-f]{9,16}', '0xRELOC'
        $text = $text -replace '\s*;; offset=0x[0-9A-Fa-f]+', ''
        Set-Content -LiteralPath "$OutputDirectory/$($runtime[0]).normalized.asm" -Value $text -Encoding utf8
    }

    & git diff --no-index --no-prefix -- "$OutputDirectory/baseline.normalized.asm" "$OutputDirectory/intrinsic.normalized.asm" > "$OutputDirectory/header.diff"
    if ($LASTEXITCODE -gt 1) { throw 'Assembly diff failed.' }
}
finally {
    foreach ($name in $variableNames) {
        [Environment]::SetEnvironmentVariable($name, $previous[$name], 'Process')
    }
    Pop-Location
}

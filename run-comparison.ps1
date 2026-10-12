param(
    [Parameter(Mandatory)] [string] $BaselineCoreRun,
    [Parameter(Mandatory)] [string] $IntrinsicCoreRun,
    [string] $DotNetCli = 'dotnet',
    [string] $Filter = '*',
    [string] $Artifacts = 'results/full'
)

$ErrorActionPreference = 'Stop'
$oldBaseline = $env:UTF8_BASELINE_CORERUN
$oldIntrinsic = $env:UTF8_PATCHED_CORERUN
$oldCli = $env:UTF8_DOTNET_CLI

Push-Location $PSScriptRoot
try {
    $env:UTF8_BASELINE_CORERUN = (Resolve-Path -LiteralPath $BaselineCoreRun).Path
    $env:UTF8_PATCHED_CORERUN = (Resolve-Path -LiteralPath $IntrinsicCoreRun).Path
    $env:UTF8_DOTNET_CLI = (Get-Command $DotNetCli -ErrorAction Stop).Source
    & $env:UTF8_DOTNET_CLI run -c Release -- --filter $Filter --artifacts $Artifacts
    if ($LASTEXITCODE -ne 0) { throw "Benchmark process exited with $LASTEXITCODE" }
}
finally {
    $env:UTF8_BASELINE_CORERUN = $oldBaseline
    $env:UTF8_PATCHED_CORERUN = $oldIntrinsic
    $env:UTF8_DOTNET_CLI = $oldCli
    Pop-Location
}

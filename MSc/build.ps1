[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$mainFile = 'Mas_Thesis_TMU.tex'
$logFile = 'Mas_Thesis_TMU.log'
$biberLogFile = 'Mas_Thesis_TMU.blg'
$consoleLogFile = Join-Path $PSScriptRoot 'Mas_Thesis_TMU.build-output.txt'
$mainSource = Get-Content -LiteralPath (Join-Path $PSScriptRoot $mainFile) -Raw
$usesBibFile = $mainSource -match '\\providecommand\{\\TMUBibliographyMode\}\{bib\}'
$buildSucceeded = $false
$oldLcAll = $env:LC_ALL
$oldLang = $env:LANG
$env:LC_ALL = 'C'
$env:LANG = 'C'

Push-Location $PSScriptRoot
try {
    $requiredTools = @('xelatex', 'latexmk', 'makeindex')
    if ($usesBibFile) { $requiredTools += 'biber' }
    foreach ($tool in $requiredTools) {
        if (-not (Get-Command $tool -ErrorAction SilentlyContinue)) {
            throw "Required command was not found: $tool"
        }
    }

    & latexmk -C $mainFile | Out-Null
    if ($LASTEXITCODE -ne 0) {
        throw "Could not clean stale build files before compilation."
    }

    & latexmk -g -xelatex -interaction=nonstopmode -halt-on-error -file-line-error $mainFile 2>&1 |
        Tee-Object -FilePath $consoleLogFile
    $latexmkExitCode = $LASTEXITCODE
    if ($latexmkExitCode -ne 0) {
        throw "Build failed with exit code $latexmkExitCode. See $consoleLogFile."
    }

    $consoleProblems = Select-String -LiteralPath $consoleLogFile -Pattern 'xdvipdfmx:(?:warning|error)'
    if ($consoleProblems) {
        $details = ($consoleProblems | ForEach-Object { "line $($_.LineNumber): $($_.Line.Trim())" }) -join [Environment]::NewLine
        throw "PDF converter output contains unresolved problems:`n$details"
    }

    $patterns = @(
        '^!',
        'LaTeX Error',
        'Package .* Error',
        'Undefined control sequence',
        'Missing character:',
        '^LaTeX Warning:',
        '^Package .* Warning:',
        '^Class .* Warning:',
        'LaTeX Font Warning',
        'Overfull \\[hv]box',
        'Underfull \\[hv]box',
        'There were undefined references',
        'Citation .* undefined',
        '\\endL or \\endR problem',
        '\\end occurred when \\iffalse'
    )
    $allowedBidiWarnings = @(
        'Package bidi Warning: Oops! patching `\f@nch@hfbox@center'' failed.',
        'Package bidi Warning: Oops! patching `\f@nch@hfbox@fit'' failed.'
    )
    $problems = Select-String -LiteralPath $logFile -Pattern $patterns |
        Where-Object { $_.Line.Trim() -notin $allowedBidiWarnings }
    if ($problems) {
        $details = ($problems | ForEach-Object { "line $($_.LineNumber): $($_.Line.Trim())" }) -join [Environment]::NewLine
        throw "Build log contains unresolved problems:`n$details"
    }

    if ($usesBibFile -and (Test-Path -LiteralPath $biberLogFile)) {
        $biberProblems = Select-String -LiteralPath $biberLogFile -Pattern '\bWARN(?:ING)?\b|\bERROR\b'
        if ($biberProblems) {
            $details = ($biberProblems | ForEach-Object { "line $($_.LineNumber): $($_.Line.Trim())" }) -join [Environment]::NewLine
            throw "Biber log contains unresolved problems:`n$details"
        }
    }
    $buildSucceeded = $true
}
finally {
    Pop-Location
    if ($buildSucceeded -and (Test-Path -LiteralPath $consoleLogFile)) {
        Remove-Item -LiteralPath $consoleLogFile -Force
    }
    if ($null -eq $oldLcAll) { Remove-Item Env:LC_ALL -ErrorAction SilentlyContinue } else { $env:LC_ALL = $oldLcAll }
    if ($null -eq $oldLang) { Remove-Item Env:LANG -ErrorAction SilentlyContinue } else { $env:LANG = $oldLang }
}

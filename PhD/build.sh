#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

MAIN_FILE='PhD_Thesis_TMU.tex'
LOG_FILE='PhD_Thesis_TMU.log'
BIBER_LOG_FILE='PhD_Thesis_TMU.blg'
CONSOLE_LOG="${SCRIPT_DIR}/PhD_Thesis_TMU.build-output.txt"

MAIN_SOURCE="$(cat "${SCRIPT_DIR}/${MAIN_FILE}")"
USES_BIB=false
if echo "${MAIN_SOURCE}" | grep -q '\\providecommand{\\TMUBibliographyMode}{bib}'; then
    USES_BIB=true
fi

BUILD_SUCCEEDED=false

OLD_LC_ALL="${LC_ALL:-}"
OLD_LANG="${LANG:-}"
export LC_ALL='C'
export LANG='C'

cleanup() {
    if ${BUILD_SUCCEEDED} && [[ -f "${CONSOLE_LOG}" ]]; then
        rm -f "${CONSOLE_LOG}"
    fi
    if [[ -z "${OLD_LC_ALL}" ]]; then
        unset LC_ALL
    else
        export LC_ALL="${OLD_LC_ALL}"
    fi
    if [[ -z "${OLD_LANG}" ]]; then
        unset LANG
    else
        export LANG="${OLD_LANG}"
    fi
}
trap cleanup EXIT

cd "${SCRIPT_DIR}"

REQUIRED_TOOLS=(xelatex latexmk makeindex)
if ${USES_BIB}; then
    REQUIRED_TOOLS+=(biber)
fi
for tool in "${REQUIRED_TOOLS[@]}"; do
    if ! command -v "${tool}" &>/dev/null; then
        echo "Error: Required command was not found: ${tool}" >&2
        exit 1
    fi
done

if ! latexmk -C "${MAIN_FILE}" &>/dev/null; then
    echo "Error: Could not clean stale build files before compilation." >&2
    exit 1
fi

if ! latexmk -g -f -pdfxe -jobname=%A -interaction=nonstopmode -halt-on-error -file-line-error "${MAIN_FILE}" 2>&1 | tee "${CONSOLE_LOG}"; then
    LATEXMK_EXIT=${PIPESTATUS[0]}
    echo "Error: Build failed with exit code ${LATEXMK_EXIT}. See ${CONSOLE_LOG}." >&2
    exit 1
fi

CONSOLE_PROBLEMS=$(grep -nE 'xdvipdfmx:(warning|error)' "${CONSOLE_LOG}" || true)
if [[ -n "${CONSOLE_PROBLEMS}" ]]; then
    echo "Error: PDF converter output contains unresolved problems:" >&2
    echo "${CONSOLE_PROBLEMS}" >&2
    exit 1
fi

PATTERNS=(
    '^!'
    'LaTeX Error'
    'Package .* Error'
    'Undefined control sequence'
    'Missing character:'
    '^LaTeX Warning:'
    '^Package .* Warning:'
    '^Class .* Warning:'
    'LaTeX Font Warning'
    'Overfull \\[hv]box'
    'Underfull \\[hv]box'
    'There were undefined references'
    'Citation .* undefined'
    '\\endL|\\endR'
    '\\end occurred when \\iffalse'
)

COMBINED_PATTERN=$(IFS='|'; echo "${PATTERNS[*]}")

ALLOWED_BIDI_1='Package bidi Warning: Oops! patching ``f@nch@hfbox@center'"'"' failed.'
ALLOWED_BIDI_2='Package bidi Warning: Oops! patching ``f@nch@hfbox@fit'"'"' failed.'

PROBLEMS=""
while IFS= read -r line; do
    TRIMMED="$(echo "${line}" | sed 's/^[[:space:]]*[0-9]*://;s/[[:space:]]*$//')"
    if [[ "${TRIMMED}" == "${ALLOWED_BIDI_1}" ]] || [[ "${TRIMMED}" == "${ALLOWED_BIDI_2}" ]]; then
        continue
    fi
    PROBLEMS="${PROBLEMS}${line}"$'\n'
done < <(grep -nE "${COMBINED_PATTERN}" "${LOG_FILE}" 2>/dev/null || true)

if [[ -n "${PROBLEMS}" ]]; then
    echo "Error: Build log contains unresolved problems:" >&2
    echo "${PROBLEMS}" >&2
    exit 1
fi

if ${USES_BIB} && [[ -f "${BIBER_LOG_FILE}" ]]; then
    BIBER_PROBLEMS=$(grep -nE '\bWARN(ING)?\b|\bERROR\b' "${BIBER_LOG_FILE}" || true)
    if [[ -n "${BIBER_PROBLEMS}" ]]; then
        echo "Error: Biber log contains unresolved problems:" >&2
        echo "${BIBER_PROBLEMS}" >&2
        exit 1
    fi
fi

BUILD_SUCCEEDED=true
echo "Build succeeded."

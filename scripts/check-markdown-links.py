#!/usr/bin/env python3
"""Fail when a relative Markdown link points to a missing repository path."""

from __future__ import annotations

import re
import sys
from pathlib import Path
from urllib.parse import unquote


REPOSITORY_ROOT = Path(__file__).resolve().parent.parent
LINK_PATTERN = re.compile(r"!?\[[^\]]*\]\(([^)]+)\)")
EXTERNAL_PREFIXES = ("http://", "https://", "mailto:", "#", "chatgpt-conversation://")


def local_target(source: Path, raw_destination: str) -> Path | None:
    destination = raw_destination.strip()
    if not destination or destination.startswith(EXTERNAL_PREFIXES):
        return None

    if destination.startswith("<") and ">" in destination:
        destination = destination[1 : destination.index(">")]
    else:
        destination = destination.split(maxsplit=1)[0]

    destination = unquote(destination.split("#", 1)[0].split("?", 1)[0])
    if not destination:
        return None
    return (source.parent / destination).resolve()


def main() -> int:
    failures: list[tuple[Path, str]] = []
    markdown_files = sorted(REPOSITORY_ROOT.rglob("*.md"))

    for source in markdown_files:
        if ".git" in source.parts:
            continue
        text = source.read_text(encoding="utf-8")
        for destination in LINK_PATTERN.findall(text):
            target = local_target(source, destination)
            if target is not None and not target.exists():
                failures.append((source.relative_to(REPOSITORY_ROOT), destination))

    if failures:
        print("Broken relative Markdown links:")
        for source, destination in failures:
            print(f"- {source}: {destination}")
        return 1

    print(f"Checked {len(markdown_files)} Markdown files; all relative links exist.")
    return 0


if __name__ == "__main__":
    sys.exit(main())

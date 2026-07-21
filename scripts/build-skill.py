#!/usr/bin/env python3
"""Rebuild dist/copy-that-sells.skill from skills/copy-that-sells/.

The .skill file is a plain zip archive whose top-level entry is the skill
folder (copy-that-sells/...). This script is idempotent: it replaces the
existing bundle in place. File metadata is fixed so the build is reproducible;
CI verifies the bundle by extracting and diffing contents, not bytes.

Usage: python3 scripts/build-skill.py   (run from anywhere)
"""

import sys
import zipfile
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent
SKILL_NAME = "copy-that-sells"
SRC_DIR = REPO_ROOT / "skills" / SKILL_NAME
DIST_DIR = REPO_ROOT / "dist"
OUT_FILE = DIST_DIR / f"{SKILL_NAME}.skill"

EXCLUDE_NAMES = {".DS_Store"}
EXCLUDE_SUFFIXES = (".swp", ".swo")


def excluded(path: Path) -> bool:
    if ".git" in path.parts:
        return True
    if path.name in EXCLUDE_NAMES:
        return True
    if path.suffix in EXCLUDE_SUFFIXES:
        return True
    return False


def main():
    if not SRC_DIR.is_dir():
        sys.exit(f"error: source dir not found at {SRC_DIR}")
    if not (SRC_DIR / "SKILL.md").is_file():
        sys.exit(f"error: SKILL.md not found in {SRC_DIR}")

    DIST_DIR.mkdir(parents=True, exist_ok=True)

    files = sorted(p for p in SRC_DIR.rglob("*") if p.is_file() and not excluded(p))

    tmp = OUT_FILE.with_name(OUT_FILE.name + ".tmp")
    with zipfile.ZipFile(tmp, "w", compression=zipfile.ZIP_DEFLATED) as z:
        for f in files:
            arcname = f"{SKILL_NAME}/{f.relative_to(SRC_DIR).as_posix()}"
            info = zipfile.ZipInfo(arcname, date_time=(1980, 1, 1, 0, 0, 0))
            info.compress_type = zipfile.ZIP_DEFLATED
            info.external_attr = 0o644 << 16  # regular file, rw-r--r--
            z.writestr(info, f.read_bytes())
    tmp.replace(OUT_FILE)

    print(f"built {OUT_FILE}")
    print()
    print("contents:")
    with zipfile.ZipFile(OUT_FILE) as z:
        for name in z.namelist():
            print(f"  {name}")
    print()
    print(f"size: {OUT_FILE.stat().st_size // 1024}K")


if __name__ == "__main__":
    main()

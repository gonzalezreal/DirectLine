#!/bin/sh
set -e

"${PROJECT_DIR}/Tools/swiftformat" --indent tabs --stripunusedargs closure-only --decimalgrouping 3,4 --commas inline --disable hoistPatternLet "${SRCROOT}/Sources/" "${SRCROOT}/Tests/"

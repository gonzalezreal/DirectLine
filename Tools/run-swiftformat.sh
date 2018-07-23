#!/bin/sh
set -e

"${PROJECT_DIR}/Tools/swiftformat" --indent tabs --stripunusedargs closure-only --decimalgrouping 3,4 --commas inline --disable hoistPatternLet --header "\nDirectLine\n\nCopyright © {year} Guille Gonzalez. All rights reserved.\nSee LICENSE file for license.\n" "${SRCROOT}/Sources/" "${SRCROOT}/Tests/"

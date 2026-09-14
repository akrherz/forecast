#!/bin/bash
set -euo pipefail

cd ~/projects/forecast/merge

if [ $# -eq 3 ]; then
    today="$1"
    yesterday="$2"
    out="out/$3"
    # The '20' below is the first two digits of the year.  This will be
    # wrong in 2100.
    target="/fcst/20$3"
else
    today="$(date --date='1 day ago' +%y%m%d)"
    yesterday="$(date --date='2 day ago' +%y%m%d)"
    out="out/$(date --date='3 days ago' +%y%m%d)"
    target="/fcst/$(date --date='3 days ago' +%Y%m%d)"
fi

output="${out}.out"
final="${target}.out"
perl merge.pl "${today}" "${yesterday}" > "$output"
if [ ! -s "$output" ]; then
    echo "Fix ${output}" | mail -s "forecast verification failure" akrherz@iastate.edu
else
    cp "$output" "$final"
fi

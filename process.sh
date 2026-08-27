#!/bin/bash

if [ $# -eq 2 ]; then
    date="$1"
    sdate="$2"
else
    date="$(date --date '1 day ago' +%Y%m%d)"
    sdate="$(date --date '1 day ago' +%y%m%d)"
fi

gempak/doadv "${date}" "${sdate}"
gempak/doclouds "${date}" "${sdate}"
gempak/dorh "${date}" "${sdate}"
gempak/dotemp "${date}" "${sdate}"
gempak/dosurf "${date}" "${sdate}"
gempak/doprecip "${date}" "${sdate}"
for hr in 01 04 07 10 13 16 19 22; do
    bash fronts/newfronts.sh "${date}" "${hr}"
done

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
fronts/newfronts "${date}" 01
fronts/newfronts "${date}" 04
fronts/newfronts "${date}" 07
fronts/newfronts "${date}" 10
fronts/newfronts "${date}" 13
fronts/newfronts "${date}" 16
fronts/newfronts "${date}" 19
fronts/newfronts "${date}" 22

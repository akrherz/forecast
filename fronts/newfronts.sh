#!/bin/bash
# The first argument is the day, and the second is the hour.

cd ~/projects/forecast/fronts || exit
PATH=~/bin:$PATH
export PATH
DATA=/data/text/frt/
export DATA

if [ "${1}" == "today" ]; then
    day=$(date -u +%Y%m%d)
else
    day=$(date --date="${1}" -u +%Y%m%d)
fi
target="${day}${2}.frt"
if [ ! -f "${DATA}/${target}" ]; then
    echo "Front file ${target} missing, trying hour+1"
    target="${day}$(printf "%02d" $((10#${2}+1))).frt"
fi
if [ ! -f "${DATA}/${target}" ]; then
    echo "Front file ${target} missing, exiting"
    exit 1
fi
cp "${DATA}/${target}" tmp/

for type in COLD OCFNT STNRY WARM; do
    # grab the file for the named hour, the hour before, and the hour after.
    # only one will exist...
    ./front_convert "tmp/${target}" "$type"

    echo "${day}${2}.${type}" > front.data
    gawk -f fronts.awk < city.list
    touch close.txt far.txt
    (sort close.txt far.txt | uniq > "fcst/raw/${day}${2}.${type}") >& /dev/null
    rm close.txt far.txt >& /dev/null
    mv err.txt "fcst/raw/${day}${2}_${type}.err" >& /dev/null
done

rm front.data tmp/*.frt ./*.COLD ./*.OCFNT ./*.STNRY ./*.WARM

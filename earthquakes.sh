#!/usr/bin/env bash
set -euo pipefail

API_URL="https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson"
# Fetch JSON
json=$(curl -s "$API_URL")

# Parse and filter with jq
echo "$json" | jq -r '.features[]
    | {mag: .properties.mag, place: .properties.place, time: (.properties.time/1000 | strftime("%Y-%m-d %H:%M:%S"))}
    | select(.mag >= 4.5)
    | [.time, .mag, .place] | @tsv' \
  | sort -k2nr \
  | awk -F'\t' 'BEGIN { OFS="\t"; print "Time","Mag","Place"} {print $1,$2,$3}'

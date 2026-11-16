#!/usr/bin/env bash

set -a
source .env
set +a

USER_AGENT="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
CONN_TIMEOUT=5
MAX_TIME=10

CURRENT_WEATHER_DATA_CURL_OUTPUT=$(curl -Ls --get \
  -A "$USER_AGENT" \
  --connect-timeout "$CONN_TIMEOUT" \
  --max-time "$MAX_TIME" \
  --data-urlencode "q=${CITY},${STATE},${COUNTRY_CODE}" \
  --data-urlencode "key=${WEATHERAPI_KEY}" \
  "https://api.weatherapi.com/v1/current.json")

#echo "${CURRENT_WEATHER_DATA_CURL_OUTPUT}" | jq .

#{
#  "location": {
#    "name": "Moalboal",
#    "region": "Cebu",
#    "country": "Philippines",
#    "lat": 9.9433,
#    "lon": 123.3992,
#    "tz_id": "Asia/Manila",
#    "localtime_epoch": 1794869208,
#    "localtime": "2026-11-17 06:46"
#  },
#  "current": {
#    "last_updated_epoch": 1794869100,
#    "last_updated": "2026-11-17 06:45",
#    "temp_c": 24.9,
#    "temp_f": 76.9,
#    "is_day": 1,
#    "condition": {
#      "text": "Patchy rain nearby",
#      "icon": "//cdn.weatherapi.com/weather/64x64/day/176.png",
#      "code": 1063
#    },
#    "wind_mph": 3.4,
#    "wind_kph": 5.4,
#    "wind_degree": 60,
#    "wind_dir": "ENE",
#    "pressure_mb": 1013.0,
#    "pressure_in": 29.91,
#    "precip_mm": 0.01,
#    "precip_in": 0.0,
#    "humidity": 89,
#    "cloud": 54,
#    "feelslike_c": 29.2,
#    "feelslike_f": 84.6,
#    "windchill_c": 24.9,
#    "windchill_f": 76.9,
#    "heatindex_c": 27.6,
#    "heatindex_f": 81.7,
#    "dewpoint_c": 23.1,
#    "dewpoint_f": 73.5,
#    "vis_km": 10.0,
#    "vis_miles": 6.0,
#    "uv": 0.0,
#    "gust_mph": 7.2,
#    "gust_kph": 11.6,
#    "will_it_rain": 0,
#    "chance_of_rain": 20,
#    "will_it_snow": 0,
#    "chance_of_snow": 0,
#    "wetbulb_c": 23.6,
#    "wetbulb_f": 74.5,
#    "short_rad": 3.36,
#    "diff_rad": 3.36,
#    "dni": 0.0,
#    "gti": 0.0
#  }
#}

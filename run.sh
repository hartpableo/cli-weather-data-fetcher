#!/usr/bin/env bash

set -a
source .env
set +a

USER_AGENT="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
CONN_TIMEOUT=5
MAX_TIME=10

CURL_OUTPUT=$(curl -Ls --get \
  -A "$USER_AGENT" \
  --connect-timeout "$CONN_TIMEOUT" \
  --max-time "$MAX_TIME" \
  --data-urlencode "q=${CITY},${STATE},${COUNTRY_CODE}" \
  --data-urlencode "limit=1" \
  --data-urlencode "appid=${OPENWEATHER_API_KEY}" \
  "http://api.openweathermap.org/geo/1.0/direct")

# [{"name":"Moalboal","lat":9.9372185,"lon":123.3921896,"country":"PH","state":"Cebu"}]


#!/usr/bin/env bash

# Resolve the directory where the script actually resides (resolving symlinks)
SCRIPT_SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SCRIPT_SOURCE" ]; do
  SCRIPT_DIR="$(cd -P "$(dirname "$SCRIPT_SOURCE")" >/dev/null 2>&1 && pwd)"
  SCRIPT_SOURCE="$(readlink "$SCRIPT_SOURCE")"
  [[ $SCRIPT_SOURCE != /* ]] && SCRIPT_SOURCE="$SCRIPT_DIR/$SCRIPT_SOURCE"
done
SCRIPT_DIR="$(cd -P "$(dirname "$SCRIPT_SOURCE")" >/dev/null 2>&1 && pwd)"

if [[ -f "$SCRIPT_DIR/.env" ]]; then
  set -a
  source "$SCRIPT_DIR/.env"
  set +a
fi

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

IFS=$'\t' read -r NAME REGION COUNTRY CONDITION LAST_UPDATE TEMP_CELSIUS < <(
	jq -r '[
		.location.name,
		.location.region,
		.location.country,
		.current.condition.text,
		.current.last_updated,
		.current.temp_c
	] | @tsv' <<< "${CURRENT_WEATHER_DATA_CURL_OUTPUT}"
)

LAST_UPDATE_HUMAN_READABLE=$(date -d "${LAST_UPDATE}" +"%B %d, %Y at %r")

echo ""
echo "  ${NAME}, ${REGION}, ${COUNTRY}"
echo "  ${LAST_UPDATE_HUMAN_READABLE}"
echo "    = ${CONDITION}"
echo "    = ${TEMP_CELSIUS}°C"
echo ""

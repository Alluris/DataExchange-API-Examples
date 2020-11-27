#!/bin/bash -e
BASE_URL="http://localhost:3000"

# Schritt 1: Letzte Messung als JSON abfragen
JSON_PATH=$(wget -qO - "$BASE_URL/measurements/info/last" | jq -r '.filename')

# im measurement_digest stehen ganze Pfade, die API arbeitet aber nur mit JSON-Dateinamen
JSON_FN=$(basename "$JSON_PATH")
echo "Dateiname Messung: $JSON_FN"

# Schritt 2: Export anstoßen (kann lange dauern), gibt ein JSON zurück
EXPORT_FN=$(wget -qO - "$BASE_URL/measurements/download/xlsx/$JSON_FN/true/null/null" | jq -r '.filename')
echo "Dateiname Export: $EXPORT_FN"

# Schritt 3: Export herunterladen
EXPORT_FN_ESCAPED=$(echo "$EXPORT_FN" | sed s/\#/%23/g)
wget -q "$BASE_URL/measurements/temp_download/$EXPORT_FN_ESCAPED"
echo "Datei als ./$EXPORT_FN abgelegt"

#!/bin/bash -e
BASE_URL="http://localhost:3000"

# Schritt 1: Alle Messungen als JSON abfragen, gibt komplettes measurement_digest als JSON zurück
MEASUREMENT_DIGEST=$(wget -qO - $BASE_URL/measurement_info/all)

# Jetzt kann das Skript die Messung filtern, die es gerne hätte, zB.
JSON_PATH=$(echo "$MEASUREMENT_DIGEST" | jq -r '.[0].names[0].descriptions[0].measurements[0].filename')
# im measurement_digest stehen ganze Pfade, die API arbeitet aber nur mit JSON-Dateinamen
JSON_FN=$(basename "$JSON_PATH")

# Schritt 2: Export anstoßen (kann lange dauern), gibt ein JSON zurück
EXPORT_FN=$(wget -qO - "$BASE_URL/measurements/download/xlsx/$JSON_FN/true/null" | jq -r '.filename')
echo "Dateiname Export: $EXPORT_FN"

# Schritt 3: Export herunterladen
EXPORT_FN_ESCAPED=$(echo "$EXPORT_FN" | sed s/\#/%23/g)
wget -q "$BASE_URL/measurements/temp_download/$EXPORT_FN_ESCAPED"
echo "Datei als ./$EXPORT_FN abgelegt"

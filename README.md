# DataExchange-API-Examples
Dieses Repository enthält mehrere Beispielskripte, um die DataExchange-HTTP-API zu anzusprechen. Es wird referenziert in der API-Dokumentation, die im [Alluris Kundenportal](https://portal.alluris.de/) zu finden ist. Dort können Details zur Funktionsweise der einzelnen API-Endpunkte erfahren werden.

## Bash examples
In diesem Ordner finden Sie Beispielskripte, um die DataExchange-API per Bash-Skript anzusprechen.

### Beispiele
- `measurement_api_last.sh`: Erfragt den JSON-Dateinamen der letzte Messung (serverseitig höchster measurement_stop integer) und lädt die Messung als XLSX
- `measurement_api_all.sh`: Erfragt alle vorhandenen Messungen und filtert sich per jq einen JSON-Dateinamen, lädt die Messung als XLSX
- `measurement_api_multiple.sh`: Erfragt alle vorhandenen Messungen und filtert sich per jq zwei JSON-Dateinamen, lädt die Messungen als ZIP mehrerer XLSX-Dateien
- `measurement_api_authenticated.sh`: Generiert eine Session mit den Zugangsdaten eines Anlagenadmins-/bedieners und erfragt die letzte Messung

### Abhängigkeiten
- `jq`: Da einige Endpunkte mit JSON-Strings antworten, wird in den Beispielen `jq` verwendet (`sudo apt install jq`).
- `curl` vs. `wget`: Da einige URLs systembedingt Sonderzeichen enthalten (Kategorie, Name und Beschreibung eines Prüfplans können in Dateinamen vorkommen), müssen URLs ggf. kodiert werden. `wget` zeigte sich hier in der Bedienung komfortabler als `curl`.

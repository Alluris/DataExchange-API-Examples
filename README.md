# DataExchange-API-Examples
Dieses Repository enthält mehrere Beispielskripte, um die DataExchange-HTTP-API zu anzusprechen. Es wird referenziert in der API-Dokumentation, die im [Alluris Kundenportal](https://portal.alluris.de/) zu finden ist. Dort können Details zur Funktionsweise der einzelnen API-Endpunkte erfahren werden.

## Bash examples
Im Ordner `bash-examples/` finden Sie Beispielskripte, um die DataExchange-API per Bash-Skript anzusprechen.

### Beispiele
- `measurement_api_last.sh`: Erfragt den JSON-Dateinamen der letzte Messung (serverseitig höchster measurement_stop integer) und lädt die Messung als XLSX
- `measurement_api_all.sh`: Erfragt alle vorhandenen Messungen und filtert sich per jq einen JSON-Dateinamen, lädt die Messung als XLSX
- `measurement_api_multiple.sh`: Erfragt alle vorhandenen Messungen und filtert sich per jq zwei JSON-Dateinamen, lädt die Messungen als ZIP mehrerer XLSX-Dateien
- `measurement_api_authenticated.sh`: Generiert eine Session mit den Zugangsdaten eines Anlagenadmins-/bedieners und erfragt die letzte Messung als authorisierter Nutzer

### Abhängigkeiten
- `jq`: Da einige Endpunkte mit JSON-Strings antworten, wird in den Beispielen `jq` verwendet (`sudo apt install jq`).

### Anmerkungen
- `jq` wird mit dem Parameter `--raw-output / -r` aufgerufen, da die (String-)Rückgabe sonst von doppelten Anführungszeichen umschlossen ist und nicht als URL-Parameter weiterverwendet werden kann
- `curl` vs. `wget`: Da einige URLs systembedingt Sonderzeichen enthalten (Kategorie, Name und Beschreibung eines Prüfplans können in Dateinamen vorkommen), müssen URLs ggf. kodiert werden. `wget` zeigte sich hier in der Bedienung komfortabler als `curl`.
- `wget` kodiert im Test alles bis auf das Doppelkreuz `#`, darum muss das vorher an einer Stelle mit sed ersetzt werden (siehe Beispiel-Skripte).

## VBA examples
Im Ordner `vba-examples/` finden Sie Beispielskripte, um die DataExchange-API per VBA-Skript anzusprechen.
Sie können eine "Excel-Arbeitsmappe mit Makros" erstellen (`.xlsm`), per Alt-F11 den VBA-Editor öffnen und dort den Code beispielsweise an das Tabellenblatt (Standard: "Tabelle1") hängen.

### Beispiele
- `ExportLastMeasurement.vba`: Erfragt den JSON-Dateinamen der letzte Messung, lädt die Messung als XLSX und öffnet diese als Arbeitsmappe

### Anmerkungen
- Die Beispiele verwenden [VBA-JSON](https://github.com/VBA-tools/VBA-JSON), um JSON-Antworten der API zu parsen. Bitte konsultieren Sie die dortige Installationsanleitung, um die Bibliothek ebenfalls zu verwenden.

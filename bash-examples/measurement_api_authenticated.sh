#!/bin/bash -e

# Schritt 1: Sitzung generieren
curl -c cookie_store http://localhost:3000/login --data 'username=Service (abc)&password=abc'
echo -e "\n"

# Schritt 2: Sitzung verwenden
curl -b cookie_store http://localhost:3000/measurement_info/last
echo -e "\n"

# Schritt 3: Sitzung zerstören
curl -b cookie_store http://localhost:3000/logout

# Aufräumen
rm cookie_store
echo -e "\n"

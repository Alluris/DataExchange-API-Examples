#!/bin/bash -e

# Schritt 1: Sitzung generieren
curl -c cookie_store http://localhost:3000/session/login --data 'username=Service (abc)&password=abc'

# FMT-978 - Bitte achten Sie darauf, dass niemand anderes eingeloggt ist
# curl -c cookie_store http://localhost:3000/session/login --data 'password=1234&hint_read=1'
echo -e "\n"

# Schritt 2: Sitzung verwenden
curl -b cookie_store http://localhost:3000/measurements/info/last
echo -e "\n"

# Schritt 3: Sitzung zerstören
curl -b cookie_store http://localhost:3000/session/logout

# Aufräumen
rm cookie_store
echo -e "\n"

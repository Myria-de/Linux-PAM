#!/bin/bash
input="users_and_passwords.txt"
output="users_and_passwords_sha512.txt"
while IFS=: read -r f1 f2
do
  HASH=`mkpasswd $f2 -m sha-512` # verschlüsseltes Passwort erzeugen
  echo "$f1" >> $output
  echo "$HASH" >> $output
done < "$input"
# Datenbank erstellen
db_load -T -f $output -t hash userpass.db
sudo mv userpass.db /etc/userpass.db
# Besitzer und Zugriffsrechte ändern
sudo chown root:root /etc/userpass.db
sudo chmod 0600 /etc/userpass.db

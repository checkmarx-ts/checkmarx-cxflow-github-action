#!/bin/bash
set -e

certs_dir="$1"

# java 8 specific location
jvm_keystore="/etc/ssl/certs/java/cacerts"

count=1
for cert in $certs_dir/*.crt
do
  echo "importing cert $cert"
  keytool -trustcacerts -importcert \
    -alias "checkmarx${count}" \
    -file "$cert" \
    -keystore "$jvm_keystore" \
    -storepass 'changeit' -noprompt
  
  # increment count
  ((count++))
done

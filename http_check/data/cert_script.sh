#!/bin/bash

printf '%s\n' "Creating root CA certificate private key..."
openssl genrsa -out rootCA.key 4096

printf '%s\n' "Creating and self-signing root certificate with the root CA private key..."
openssl req -x509 -new -nodes -key rootCA.key -sha256 -days 1024 -subj "/C=US/ST=NY/O=Datadog/OU=Agent/CN=$HOSTNAME" -out rootCA.crt

printf '%s\n' "Creating the client certificate key..."
openssl genrsa -out $HOSTNAME.key 2048

printf '%s\n' "Creating the Certificate Signing Request..."
openssl req -new -sha256 -key $HOSTNAME.key -subj "/C=US/ST=NY/L=New York/O=Datadog/OU=Agent/CN=$HOSTNAME" -out $HOSTNAME.csr

printf '%s\n' "Verifying the Certificate Signing Request Content..."
openssl req -in $HOSTNAME.csr -noout -text

printf '%s\n' "Generating the client certificate with the CSR, root CA cert, root CA private key..."
openssl x509 -req -in $HOSTNAME.csr -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -out $HOSTNAME.crt -days 500 -sha256

printf '%s\n' "Verifying the client certificate's content..."
openssl x509 -in $HOSTNAME.crt -text -noout

printf '%s\n\n' "Test your certs on a local endpoint!"
printf '%s\n\n' "> Start the http-server:" \
    "http-server -S -C ./$HOSTNAME.crt -K ./$HOSTNAME.key -a '$HOSTNAME' . -p 8080"

printf '%s\n\n' "> Run curl against the endpoint with root CA cert:" \
    "curl --cacert ./rootCA.crt https://$HOSTNAME:8080/ssl-tls.md"
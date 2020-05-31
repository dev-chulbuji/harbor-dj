#!/bin/bash

set -e

if [[ -z $1 ]]; then
        echo "Usage: $0 <HOST>"
        exit 1
fi

HOST=$1
CHDIR="./certs"

rm -rf $CHDIR
mkdir -p $CHDIR

echo "Generating self-signed root CA"
openssl genrsa -out $CHDIR/ca.key 2048
openssl req -new -subj "/C=KR" -x509 -days 365 -key $CHDIR/ca.key -sha256 -out $CHDIR/ca.crt


echo "Generating server key and certificate"
openssl genrsa -out $CHDIR/server.key 2048
openssl req -subj "/CN=*" -sha256 -new -key $CHDIR/server.key -out $CHDIR/server.csr
echo subjectAltName = IP:$HOST,IP:127.0.0.1 >> $CHDIR/extfile.cnf
echo extendedKeyUsage = serverAuth >> $CHDIR/extfile.cnf

openssl x509 -req -days 365 -sha256 -in $CHDIR/server.csr -CA $CHDIR/ca.crt -CAkey $CHDIR/ca.key -CAcreateserial -out $CHDIR/server.crt -extfile $CHDIR/extfile.cnf

echo "Generating client  key and certificate"
openssl genrsa -out $CHDIR/client.key 2048
openssl req -subj '/CN=client' -new -key $CHDIR/client.key -out $CHDIR/client.csr
echo extendedKeyUsage = clientAuth > $CHDIR/extfile-client.cnf
openssl x509 -req -days 365 -sha256 -in $CHDIR/client.csr -CA $CHDIR/ca.crt -CAkey $CHDIR/ca.key -CAcreateserial -out $CHDIR/client.crt -extfile $CHDIR/extfile-client.cnf

echo "Cleaning up"
rm -rf $CHDIR/*.cnf $CHDIR/*.csr

touch $CHDIR/done

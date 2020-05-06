@ECHO OFF
Rem execute this script from the dds_secure_workbook\ca\identity\ directory
Rem this will overwrite existing files

ECHO generating private key and placing it in private\identcapriv.pem
ECHO      openssl ecparam -name secp256k1 -genkey -noout -out private\identcapriv.pem
openssl ecparam -name secp256k1 -genkey -noout -out private\identcapriv.pem
ECHO.

ECHO generating certificate signing request (identca.csr) based on private key and openssl.cnf
ECHO      openssl req -new -sha256 -key private\identcapriv.pem -out identca.csr -config openssl.cnf
openssl req -new -sha256 -key private\identcapriv.pem -out identca.csr -config openssl.cnf
ECHO.

ECHO generating the CA certificate (identcacert.pem) based on the .csr certificate request and private key
ECHO      openssl x509 -req -sha256 -days 3650 -in identca.csr -text -signkey private\identcapriv.pem -out identcacert.pem
openssl x509 -req -sha256 -days 3650 -in identca.csr -text -signkey private\identcapriv.pem -out identcacert.pem
ECHO.

ECHO removing identca.csr file that is no longer needed now that the identity ca is signed
del identca.csr
ECHO.

ECHO copying the public identcacert.pem to the deployall directory (..\..\apps\deployall\)
copy identcacert.pem ..\..\apps\deployall\
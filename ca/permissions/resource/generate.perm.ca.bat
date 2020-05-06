@ECHO OFF
Rem execute this script from the dds_secure_workbook\ca\permissions\ directory
Rem this will overwrite existing files

ECHO generating private key and placing it in private\permcapriv.pem
ECHO      openssl ecparam -name secp256k1 -genkey -noout -out private\permcapriv.pem
openssl ecparam -name secp256k1 -genkey -noout -out private\permcapriv.pem
ECHO.

ECHO generating certificate signing request (identca.csr) based on private key and openssl.cnf
ECHO      openssl req -new -sha256 -key private\permcapriv.pem -out permca.csr -config openssl.cnf
openssl req -new -sha256 -key private\permcapriv.pem -out permca.csr -config openssl.cnf
ECHO.

ECHO generating the permissions CA certificate (permcacert.pem) based on the .csr certificate request and private key
ECHO      openssl x509 -req -sha256 -days 3650 -in permca.csr -text -signkey private\permcapriv.pem -out permcacert.pem
openssl x509 -req -sha256 -days 3650 -in permca.csr -text -signkey private\permcapriv.pem -out permcacert.pem
ECHO.

ECHO removing permca.csr file that is no longer needed now that the permissions ca is signed
del permca.csr
ECHO.

ECHO copying the public permcacert.pem to the deployall directory (..\..\apps\deployall\)
copy permcacert.pem ..\..\apps\deployall\
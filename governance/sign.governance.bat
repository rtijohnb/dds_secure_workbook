@ECHO OFF
Rem this script generates the applications identity certificate and signed permissions file
Rem run this script from the governance\ folder

ECHO generating the signed governance file using the permissions CA and saving it to demo_governance_signed.p7s
ECHO      openssl smime -sign -in demo_governance.xml -text -out demo_governance_signed.p7s -signer ..\ca\permissions\permcacert.pem -inkey ..\ca\permissions\private\permcapriv.pem
openssl smime -sign -in demo_governance.xml -text -out ..\apps\deployall\demo_governance_signed.p7s -signer ..\ca\permissions\permcacert.pem -inkey ..\ca\permissions\private\permcapriv.pem
ECHO.

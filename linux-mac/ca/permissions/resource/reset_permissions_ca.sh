# TODO: Add check to make sure script is not running from resource directory
rm certs/*
rm PermissionsDatabase
rm PermissionsDatabaseIndex.*
rm *.csr
rm *.pem
rm *.cnf
rm *.old
rm private/*
cp ./resource/PermissionsDatabase .
cp ./resource/PermissionsDatabaseIndex.txt .
cp ./resource/openssl.cnf .


# TODO: Add check to make sure script is not running from resource directory
rm certs/*
rm CertificateDatabase
rm CertificateDatabaseIndex.*
rm *.csr
rm *.pem
rm *.cnf
rm private/*
cp ./resource/CertificateDatabase .
cp ./resource/CertificateDatabaseIndex.txt .
cp ./resource/openssl.cnf .


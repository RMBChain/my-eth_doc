wsl
cd /server_cert
chmod 600 chainSecretKeyBJ.pem
ssh-agent bash
ssh-add chainSecretKeyBJ.pem
ssh root@39.105.153.126 // or ssh -i chainSecretKeyBJ.pem root@39.105.153.126

wsl
cd /server_cert
chmod 600 chainSecretKeyBJ.pem
ssh-agent bash
ssh-add chainSecretKeyBJ.pem
ssh root@39.105.18.23   // or ssh -i chainSecretKeyBJ.pem root@39.105.18.23

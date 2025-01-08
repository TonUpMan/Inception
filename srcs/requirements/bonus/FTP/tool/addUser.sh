#!bin/bash

USERNAME="${FTP_USER}"
PASSWORD="${FTP_PASS}"
FTP_DIR="/home/$USERNAME"

echo "Ajout de l'utilisateur FTP : $USERNAME"

useradd -m -d $FTP_DIR -s /bin/false $USERNAME &&
echo "$USERNAME:$PASSWORD" | chpasswd &&
mkdir -p $FTP_DIR &&
chown $USERNAME:$USERNAME -R $FTP_DIR &&
chmod 755 $FTP_DIR
usermod -s /bin/bash qdeviann


exec /usr/sbin/proftpd -n

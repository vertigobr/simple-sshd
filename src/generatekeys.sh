# in derived images it might be a good idea to
# regenerate the sshd keys
rm -f /etc/ssh/ssh_host_rsa_key
rm -f /etc/ssh/ssh_host_ecdsa_key
/usr/bin/ssh-keygen -A


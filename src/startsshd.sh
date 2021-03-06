#!/bin/sh
#

# force password
[ -z "$USERPWD" ] && USERPWD="secret"
echo "$USERPWD" | passwd user --stdin

# create .ssh folder
mkdir -p /home/user/.ssh
chmod 700 /home/user/.ssh
mkdir -p /root/.ssh
chmod 700 /root/.ssh

# copies public key if non-empty
if [ ! -z "$PUBLICKEY" ]; then
    echo "Adjusting public key..."
    echo "$PUBLICKEY" > /home/user/.ssh/authorized_keys
    chmod 600 /home/user/.ssh/authorized_keys
fi

# copies public key for root user
if [ ! -z "$PUBLICROOTKEY" ]; then
    echo "Adjusting public key for root..."
    echo "$PUBLICROOTKEY" > /root/.ssh/authorized_keys
    chmod 600 /root/.ssh/authorized_keys
fi

# disables password auth if asked
if [[ "$KEYONLY" == "true" ]]; then
    echo "disabling password authentication..."
    sed "s/^PasswordAuthentication.*/PasswordAuthentication no/g" -i /etc/ssh/sshd_config
else
    sed "s/^PasswordAuthentication.*/PasswordAuthentication yes/g" -i /etc/ssh/sshd_config
fi

# fix owner
chown -R user:user /home/user/.ssh

exec /usr/sbin/sshd -D

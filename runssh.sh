SSHPORT=${SSHPORT:-8022}
PUBLICKEY=`cat ~/.ssh/id_rsa.pub`
docker stop sshd
docker rm sshd
echo "Will use $SSHPORT port"
docker run --name sshd -d \
    -p $SSHPORT:22 \
    -e "PUBLICKEY=$PUBLICKEY" \
    -e "KEYONLY=true" \
    vertigo/simple-sshd:latest


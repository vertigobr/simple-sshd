ENVBASH=$1
ENVBASH=${ENVBASH:-"bash"}
SSHPORT=${SSHPORT:-8022}
docker stop sshd
docker rm sshd
echo "Will use $SSHPORT port"
docker run --rm -ti -p $SSHPORT:22 vertigo/simple-sshd:latest $ENVBASH ${@:2}


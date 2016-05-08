# simple-sshd

Simple SSHD container (no systemd)


## Why this?

This image is meant to be used for a ssh login into a container and fiddle around. Sometimes you need these things.

## Is it a Docker host?

If you are looking for a way to use this container to control a Docker host please use "bacen/carina-sshd" instead.

## What is installed?

* SSHD (from yum repo)

## Environment variables

These variables can be set on "docker run":

* PUBLICKEY: you can set this to the content of a public key that will be pushed into "authorized_keys" for the user "user".
* KEYONLY: if "true" user will only be able to login with a key.
* USERPWD: password that will be set for user "user".

## How to use (crude way)

This will run the sshd container on port 8022, accepting password "senha" for user "user".

```
docker run --name sshd -d \
    -p 8022:22 \
    -e "USERPWD=senha" \
    -e "KEYONLY=false" \
    bacen/sshd
```

To test the connection:

```
ssh user@yourhost -p 8022
```

## How to use (fancy way)

This will run the sshd container on port 8022, accepting only key-based logins for user "user". The public key contents were drawn from your local "id_rsa.pub", but you can pick any other, of course.

```
PUBLICKEY=`cat ~/.ssh/id_rsa.pub`
docker run --name sshd -d \
    -p 8022:22 \
    -e "PUBLICKEY=$PUBLICKEY" \
    -e "KEYONLY=true" \
    bacen/sshd:latest
```

To test the connection with the defautl private key (~/.ssh/id_rsa):

```
ssh user@yourhost -p 8022
```

Or, if you want to use another private key:

```
ssh user@yourhost -p 8022 -i ~/.ssh/anotherkey
```

## How to use (even more fancy)

You can run the container the fancy way (above) and configure your own ssh client to provide several convenient settings. You must insert this into your local "~/.ssh/config" (please replace "xxx.xxx.xxx.xxx" for your host's IP address):

```
# Carina host
Host myserver
    HostName xxx.xxx.xxx.xxx
    Port 8022
    User user
#    IdentityFile ~/.ssh/anotherkey
```

With these settings you can connect safer and simpler:

```
ssh myserver
```

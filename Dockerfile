
FROM centos

RUN yum install wget openssh-server openssh-clients passwd sudo -y && \
    yum clean all

ENV USERPWD secret
ENV PUBLICKEY ""
ENV KEYONLY false

ADD src/*.sh /opt/

RUN useradd -u 5001 -G users -m user && \
    echo "$USERPWD" | passwd user --stdin && \
    chmod +x /opt/*.sh && \
    sh /opt/generatekeys.sh && \
    sed -i '/^session.*pam_loginuid.so/s/^session/# session/' /etc/pam.d/sshd && \
    sed -i 's/Defaults.*requiretty/#Defaults requiretty/g' /etc/sudoers

# passwordless sudo
ADD src/user /etc/sudoers.d/user

EXPOSE 22

CMD ["/opt/startsshd.sh"]

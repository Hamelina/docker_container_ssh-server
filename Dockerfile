FROM ubuntu:16.04

RUN apt-get update && apt-get install -y --no-install-recommends apt-utils

RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd



RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/^#?PasswordAuthentication\s+.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
RUN sed -ri 's/^#?PubKeyAuthentication\s+.*/PubKeyAuthentication yes/' /etc/ssh/sshd_config
#RUN sed -ri 's/^#?AuthorizedKeysFile\s+.*/AuthorizedKeysFile .ssh/authorized_keys/' /etc/ssh/sshd_config
RUN service ssh restart

RUN mkdir /root/.ssh
RUN ssh-keygen -A
RUN ssh-keygen -t dsa -P '' -f ~/.ssh/id_dsa
#RUN echo "ssh-rsa [rsa_publique_key" > ~/.ssh/authorized_keys
RUN echo 'root:12345' |chpasswd
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#RUN useradd -rd /opt/mongo_0 mongo_0
RUN useradd -rdms /bin/bash newUser

RUN echo 'newUser:newUser' |chpasswd

EXPOSE 22
RUN cat /etc/ssh/sshd_config
CMD    ["/usr/sbin/sshd", "-D"]
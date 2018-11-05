FROM ubuntu:16.04

RUN apt-get update && apt-get install -y --no-install-recommends apt-utils

RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd



RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/^#PasswordAuthentication\s+.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
RUN sed -ri 's/^#PubKeyAuthentication\s+.*/PubKeyAuthentication yes/' /etc/ssh/sshd_config
RUN sed -ri 's/^#AuthorizedKeysFile\s+.*/AuthorizedKeysFile .ssh/authorized_keys/' /etc/ssh/sshd_config

RUN mkdir /root/.ssh
RUN ssh-keygen -A
RUN ssh-keygen -t dsa -P '' -f ~/.ssh/id_dsa
RUN echo "AAAAB3NzaC1yc2EAAAADAQABAAABAQDwdKU5VEIh7yl+ZzpeCTxo6UAFypjweW4hCPttP43U1fSGP2IQem6mT/xPYzoLt9dxMXSPNDkSZO2evJ40eVaPwi2x4dFb7WNhWwVGEdXrKo0lAIjfdp89IqZ9Q+1KIavUEafB5xVoMpFYix1h/a9JnxDyuLcMBjayVPEyWRK6cN04mzh+wkX8qeyn/RqAPmICYTHNYYn8rXq6P4GEaV4wgmffsDQltMZE+IfOi/B0qI+nhoQmqRfd9nuEqDeSIUK8smK/OjKszG/yZJLknrUrRjpzkNfL194xz13S1/lOzHuaOiBwthShvqS1mRnhjnx8ojwD0sCi78P1qpQkHAzH" > ~/.ssh/authorized_keys
RUN echo 'root:12345' |chpasswd
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


RUN useradd -ms /bin/bash newUser
RUN echo 'newUser:newUser' |chpasswd

EXPOSE 22

CMD    ["/usr/sbin/sshd", "-D"]
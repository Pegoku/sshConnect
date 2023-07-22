FROM ubuntu:22.04
COPY sshcon /usr/bin/sshcon
# COPY connector.conf.template /root/connector.conf.template
RUN chmod +x /usr/bin/sshcon
RUN apt update && apt install -y openssh-server openssh-client bc whiptail sshpass
RUN mkdir /var/run/sshd
RUN echo 'root:mypassword' | chpasswd
RUN chmod -R 0644 /etc/update-motd.d/-
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#Port 22/Port 24/' /etc/ssh/sshd_config
RUN sed -i 'root:x:0:0:root:/root:/bin/sh/root:x:0:0:root:/root:/bin/sshcon/' /etc/passwd
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
EXPOSE 24
RUN chsh -s /bin/sshcon root
CMD ["/usr/sbin/sshd", "-D"]

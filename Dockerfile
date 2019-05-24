FROM debian:9 
RUN apt-get update 
RUN apt-get -y upgrade 
RUN apt-get -y install wget bzip2 sudo
RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt-get -y install libstdc++6:i386 libgcc1:i386 zlib1g:i386 libncurses5:i386 libgtk-3-0:i386 libdbus-glib-1-2:i386 libxt6:i386 libgtk2.0-0:i386 gnome-themes-standard gnome-themes-standard-data ffmpeg:i386
COPY jre-8u211-linux-i586.tar.gz /opt/
WORKDIR /opt/
RUN /usr/bin/wget https://ftp.mozilla.org/pub/firefox/releases/52.9.0esr/linux-i686/en-US/firefox-52.9.0esr.tar.bz2
RUN tar jfx firefox-52.9.0esr.tar.bz2
RUN tar zfx jre-8u211-linux-i586.tar.gz
RUN rm -f /opt/firefox-52.9.0esr.tar.bz2 jre-8u211-linux-i586.tar.gz
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer
COPY java.policy.global /opt/jre1.8.0_211/lib/security/java.policy
USER developer 
RUN mkdir -p /home/developer/.mozilla/plugins
RUN ln -s /opt/jre1.8.0_211/lib/i386/libnpjp2.so /home/developer/.mozilla/plugins/libnpjp2.so
RUN mkdir -p /home/developer/.java/deployment/security
COPY java.policy /home/developer/.java.policy
COPY exception.sites /home/developer/.java/deployment/security/exception.sites
ENV HOME /home/developer
ENV JAVA_HOME /opt/jre1.8.0_211
ENV PATH /opt/jre1.8.0_211/bin:/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
CMD /opt/firefox/firefox 

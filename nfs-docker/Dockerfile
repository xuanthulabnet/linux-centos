FROM centos:centos7

RUN rpmkeys --import file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7 && \
    yum -y --setopt=tsflags=nodocs install nfs-utils && \
    mkdir -p /data && \
    yum clean all

COPY nfs-start.sh /usr/local/bin/
RUN chmod +rx /usr/local/bin/nfs-start.sh

VOLUME [ "/data" ]

EXPOSE 111/udp 2049/tcp 20048/udp

ENTRYPOINT ["/usr/local/bin/nfs-start.sh"]

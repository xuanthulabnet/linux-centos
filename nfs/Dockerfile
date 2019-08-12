FROM centos:latest
RUN yum -y --setopt=tsflags=nodocs install nfs-utils \
    && yum clean all
EXPOSE 111
EXPOSE 2049

# docker run -it --rm --privileged -p 111:111 -p 2049:2049 --name nfs abc





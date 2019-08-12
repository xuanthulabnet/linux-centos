FROM debian:stretch
RUN apt-get update -y \
    && apt-get install samba vim locales -y \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
    && rm -rf /var/lib/apt/lists/*
 

RUN useradd smbuser && groupadd smbgroup \
    && usermod -a -G smbgroup smbuser        
      

ENV LANG en_US.utf8
RUN echo "Asia/Ho_Chi_Minh" > /etc/timezone   
ADD ./smb.conf /etc/samba/smb.conf
ADD ./addsambauser.sh /bin/addsambauser.sh
RUN chmod +x /bin/addsambauser.sh

WORKDIR /home/data/

EXPOSE 139 
EXPOSE 445

CMD ["smbd", "--foreground", "--log-stdout"]

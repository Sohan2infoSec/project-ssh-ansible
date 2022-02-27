FROM ubuntu

ENV TZ=Asia/Ho_Chi_Minh
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update 
RUN apt-get install -y vim python3 python3-pip supervisor openssh-server 
RUN pip install ansible==5.4.0 ## latest version ansible

COPY id_rsa.pub /root/.ssh/id_rsa.pub
COPY id_rsa /root/.ssh/id_rsa 
COPY Dockerfile /
RUN cat /root/.ssh/id_rsa.pub > /root/.ssh/authorized_keys 
RUN chmod 600 -R /root/.ssh/ 

RUN service ssh start

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf 
EXPOSE 22 
CMD ["/usr/bin/supervisord"]

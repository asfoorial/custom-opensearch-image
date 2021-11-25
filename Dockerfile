FROM redhat/ubi8
COPY sysctl.conf /etc/sysctl.conf
COPY max_map_count /proc/sys/vm/
#RUN sysctl -w vm.max_map_count=262144
RUN mkdir /usr/share/opensearch
RUN chmod 777 /usr/share/opensearch
ADD https://artifacts.opensearch.org/releases/bundle/opensearch/1.2.0/opensearch-1.2.0-linux-x64.tar.gz /usr/share/opensearch
WORKDIR /usr/share/opensearch
RUN tar -xf opensearch-1.2.0-linux-x64.tar.gz
RUN groupadd opensearch 
RUN adduser osuser -g opensearch -G 0 -d /usr/share/opensearch 

RUN chown -R osuser /usr/share/opensearch
RUN chmod -R 777 /usr/share/opensearch
WORKDIR /usr/share/opensearch/opensearch-1.2.0
COPY install.sh /usr/share/opensearch/opensearch-1.2.0/
COPY start.sh /usr/share/opensearch/opensearch-1.2.0/
#RUN yum update -y
#RUN yum install -y python3
#RUN pip3.6 install --upgrade pip
#RUN pip3.6 install flask
#COPY app.py /opt/
#EXPOSE 9200 9300
USER osuser
#ENTRYPOINT FLASK_APP=/opt/app.py flask run --host=0.0.0.0 --port=8080
RUN /usr/share/opensearch/opensearch-1.2.0/install.sh
#CMD ["/usr/share/opensearch/opensearch-1.2.0/install.sh"]
#CMD ["/usr/share/opensearch/opensearch-1.2.0/install.sh"]
COPY opensearch.yml /usr/share/opensearch/opensearch-1.2.0/config
ENTRYPOINT /usr/share/opensearch/opensearch-1.2.0/start.sh

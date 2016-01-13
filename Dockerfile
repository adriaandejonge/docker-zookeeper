FROM centos:latest

# Loosely based on the jplock/zookeeper container by Justin Plock <justin@plock.net>

RUN yum install -y \
  java-1.8.0-openjdk-headless.x86_64 \
  wget
  
RUN wget -q -O - http://apache.mirrors.pair.com/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz | tar -xzf - -C /opt \
    && mv /opt/zookeeper-3.4.6 /opt/zookeeper \
    && cp /opt/zookeeper/conf/zoo_sample.cfg /opt/zookeeper/conf/zoo.cfg \
    && mkdir -p /tmp/zookeeper

ENV JAVA_HOME /usr/lib/jvm/jre

EXPOSE 2181 2888 3888

WORKDIR /opt/zookeeper

VOLUME ["/opt/zookeeper/conf", "/tmp/zookeeper"]

ENTRYPOINT ["/opt/zookeeper/bin/zkServer.sh"]
CMD ["start-foreground"]

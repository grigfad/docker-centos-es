##SOURCING CENTOS 7.4.1708
FROM centos:7.4.1708
MAINTAINER Volodymyr Shevtsov <vova@shevtsov.eu>

##SWITCHING TO SUPERUSER EXPLICITELY
USER root

##INSTALLING SYSTEM TOOLS
RUN \
  yum -y update && yum clean all &&\
  yum install -y wget chkconfig tar

##INSTALLING JAVA 10.0.1
ARG JAVA_DIR="/usr/local/jdk-10.0.1"
RUN \
  cd /usr/local && \
  wget -qO - https://download.java.net/java/GA/jdk10/10.0.1/fb4372174a714e6b8c52526dc134031e/10/openjdk-10.0.1_linux-x64_bin.tar.gz | tar xfz -
RUN \
  alternatives --install /usr/bin/java java $JAVA_DIR/bin/java 2 && \
  echo | alternatives --config java && \
  alternatives --install /usr/bin/jar jar $JAVA_DIR/bin/jar 2 && \
  alternatives --install /usr/bin/javac javac $JAVA_DIR/bin/javac 2 && \
  alternatives --set jar $JAVA_DIR/bin/jar && \
  alternatives --set javac $JAVA_DIR/bin/javac
ENV PATH $PATH:/usr/local/$JAVA_DIR/bin

##SETTING UP ELASTICSEARCH USER ACCOUNT
RUN \
  groupadd -g 1000 elasticsearch && \
  adduser -u 1000 -g 1000 -d /usr/share/elasticsearch elasticsearch && \
  mkdir -p /usr/share/elasticsearch/data && \
  chown -R 1000:1000 /usr/share/elasticsearch && \
  chmod 0775 /usr/share/elasticsearch

##SWITCHING TO ELASTICSEARCH USER EXPLICITELY
USER 1000

##INSTALLING ELASTICSEARCH 6.2.4
ARG ES_VER="6.2.4"
ARG ES_DIR="/usr/share/elasticsearch"
RUN \
  cd /tmp && \
  wget -qO - https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${ES_VER}.tar.gz | tar xfz -
RUN \
  mv /tmp/elasticsearch-${ES_VER}/* $ES_DIR/
ENV PATH $PATH:$ES_DIR/bin

##CREATING PERSISTENT STORAGE
VOLUME $ES_DIR/data


##LAST STEPS
ENV discovery.type single-node
WORKDIR $ES_DIR
COPY config/* config/
CMD ["elasticsearch"]
EXPOSE 9200 9300

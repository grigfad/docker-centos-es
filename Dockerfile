##SOURCING CENTOS 7.4.1708
FROM centos:7.4.1708
MAINTAINER Volodymyr Shevtsov <vova@shevtsov.eu>

##SWITCHING TO SUPERUSER (EVEN THOUGH IT IS A DEFAULT)
USER root

##INSTALLING SYSTEM TOOLS
RUN \
  yum -y update && yum clean all &&\
  yum install -y wget chkconfig tar

##INSTALLING JAVA 10.0.1
ENV JAVA_HOME /usr/local/jdk-10.0.1
RUN \
  wget --quiet --no-check-certificate \
  https://download.java.net/java/GA/jdk10/10.0.1/fb4372174a714e6b8c52526dc134031e/10/openjdk-10.0.1_linux-x64_bin.tar.gz | \
  tar -C /usr/local -xfz - && \
  alternatives --install /usr/bin/java java $JAVA_HOME/bin/java 2 && \
  echo | alternatives --config java && \
  alternatives --install /usr/bin/jar jar $JAVA_HOME/bin/jar 2 && \
  alternatives --install /usr/bin/javac javac $JAVA_HOME/bin/javac 2 && \
  alternatives --set jar $JAVA_HOME/bin/jar && \
  alternatives --set javac $JAVA_HOME/bin/javac
ENV PATH $PATH:/usr/local/$JAVA_VERSION/bin

##SETTING HEAPSIZE HALF THE SIZE OF MEMORY
ENV ES_JAVA_OPTS -Xms512m -Xmx512m

##SETTING UP ELASTICSEARCH USER ACCOUNT
RUN \
  groupadd -g 1000 elasticsearch && \
  adduser -u 1000 -g 1000 -d /usr/share/elasticsearch elasticsearch
  mkdir -p /usr/share/elasticsearch/{data,logs,config,config/scripts} && \
  chown -R 1000:1000 /usr/share/elasticsearch && \
  chmod 0775 /usr/share/elasticsearch

##SWITCHING TO ELASTICSEARCH USER
USER 1000

##INSTALLING ELASTICSEARCH 6.2.4
ENV ES_HOME /usr/share/elasticsearch
ENV ES_VERSION elasticsearch-6.2.4
RUN \
  wget --quiet --no-check-certificate https://artifacts.elastic.co/downloads/elasticsearch/$ES_VERSION.tar.gz | tar -C /tmp -xfz - && \
  rm -f $ES_VERSION.tar.gz && \
  mv /tmp/$ES_VERSION/* $ES_HOME
ENV PATH $PATH:$ES_HOME/bin

##CREATING PERSISTENT STORAGE
VOLUME $ES_HOME/data


##LAST STEPS
WORKDIR $ES_HOME
COPY config/* config/
CMD ["elasticsearch"]
EXPOSE 9200 9300

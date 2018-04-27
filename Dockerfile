##SOURCING CENTOS 7.4.1708
FROM centos:7.4.1708
MAINTAINER Volodymyr Shevtsov <vova@shevtsov.eu>

##INSTALLING JAVA 10.0.1
USER root
ENV JAVA_VERSION jdk-10.0.1
ENV JAVA_HOME /usr/local/$JAVA_VERSION/
ENV PATH $PATH:/usr/local/$JAVA_VERSION/bin
RUN \
  yum -y update && yum clean all &&\
  yum install -y wget chkconfig tar && \
  wget --quiet --no-check-certificate \
  https://download.java.net/java/GA/jdk10/10.0.1/fb4372174a714e6b8c52526dc134031e/10/openjdk-10.0.1_linux-x64_bin.tar.gz && \
  tar xfz openjdk-10.0.1_linux-x64_bin.tar.gz -C /usr/local && \
  rm -f openjdk-10.0.1_linux-x64_bin.tar.gz && \
  alternatives --install /usr/bin/java java /usr/local/jdk-10.0.1/bin/java 2 && \
  echo | alternatives --config java && \
  alternatives --install /usr/bin/jar jar /usr/local/jdk-10.0.1/bin/jar 2 && \
  alternatives --install /usr/bin/javac javac /usr/local/jdk-10.0.1/bin/javac 2 && \
  alternatives --set jar /usr/local/jdk-10.0.1/bin/jar && \
  alternatives --set javac /usr/local/jdk-10.0.1/bin/javac

##SETTING UP ELASTICSEARCH
RUN useradd elasticsearch -c 'Elasticsearch User' -d /home/elasticsearch
RUN \
  mkdir -p /usr/share/elasticsearch/data && \
  chown -R elasticsearch:elasticsearch /usr/share/elasticsearch && \
  mkdir -p /usr/share/elasticsearch/data && \
  chown elasticsearch:elasticsearch /usr/share/elasticsearch/data

USER elasticsearch
ENV ES_HOME /usr/share/elasticsearch/
ENV ES_VERSION elasticsearch-6.2.4
ENV PATH $PATH:$ES_HOME/bin

##INSTALLING ELASTICSEARCH 6.2.4
RUN \
  cd /tmp && \
  wget --quiet --no-check-certificate https://artifacts.elastic.co/downloads/elasticsearch/$ES_VERSION.tar.gz && \
  tar xfz $ES_VERSION.tar.gz && \
  rm -f $ES_VERSION.tar.gz && \
  mv /tmp/$ES_VERSION/* $ES_HOME

##CREATING PERSISTENT STORAGE
VOLUME $ES_HOME/data

##LAST STEPS
COPY logging.yml $ES_CONFIG
COPY elasticsearch.yml $ES_CONFIG
CMD ["elasticsearch"]
EXPOSE 9200 9300

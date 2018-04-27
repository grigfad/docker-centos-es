# docker-centos-es
[Custom ElasticSearch Dockerfile based on CentOS 7 and Java 10.0.1]
[Opted out of using packages, switched to archives exclusively]

[CLONE]
git clone https://github.com/grigfad/docker-centos-es.git
[BUILD]
docker build -t "docker-centos-es" .
[RUN]
docker run -tdi -v /usr/share/elasticsearch/data -p 9200:9200 -p 9300:9300 docker-centos-es

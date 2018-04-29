<b>CentOS-7.4.1708/Java-10.0.1/ElasticSearch-6.2.4 Docker Implementation from sources</b>

[CLONE]
git clone https://github.com/grigfad/docker-centos-es.git
cd docker-centos-es/

[BUILD]
docker build -t "docker-centos-es" .

[RUN A SINGLE SANDBOX NODE]
docker run -tdi -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" docker-centos-es

[RUN SANDBOX CLUSTER]
docker swarm init
docker stack deploy -c docker-compose.yml docker-centos-es


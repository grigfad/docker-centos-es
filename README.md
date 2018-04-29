<!DOCTYPE html>
<title>CentOS-7.4.1708/Java-10.0.1/ElasticSearch-6.2.4 Docker Implementation from sources</title>

<h1>CLONE</h1>
<ul>
  <li>git clone https://github.com/grigfad/docker-centos-es.git</li>
  <li>cd docker-centos-es/</li>
</ul>

<h1>BUILD</h1>
<ul>
  <li>docker build -t "docker-centos-es" .</li>
</ul>

<h1>RUN A SINGLE SANDBOX NODE</h1>
<ul>
  <li>docker run -tdi -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" docker-centos-es</li>
</ul>

<h1>RUN SANDBOX CLUSTER</h1>
<ul>
  <li>docker swarm init</li>
  <li>docker stack deploy -c docker-compose.yml docker-centos-es</li>
</ul>

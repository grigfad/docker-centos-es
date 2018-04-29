<!DOCTYPE html>
<h1>CentOS-7.4.1708/Java-10.0.1/ElasticSearch-6.2.4 Docker Implementation from sources</h1>

<h2>CLONE</h2>
<code>git clone https://github.com/grigfad/docker-centos-es.git</code>
<code>cd docker-centos-es/</code>

<h2>BUILD</h2>
<ul>
  <li>docker build -t "docker-centos-es" .</li>
</ul>

<h2>RUN A SINGLE SANDBOX NODE</h2>
<ul>
  <li>docker run -tdi -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" docker-centos-es</li>
</ul>

<h2>RUN SANDBOX CLUSTER</h2>
<ul>
  <li>docker swarm init</li>
  <li>docker stack deploy -c docker-compose.yml es-cluster</li>
</ul>

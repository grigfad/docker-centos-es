<!DOCTYPE html>
<h1>CentOS-7.4.1708/Java-10.0.1/ElasticSearch-6.2.4 Docker Implementation from sources</h1>

<h2>Clone</h2>
<pre><code>git clone https://github.com/grigfad/docker-centos-es.git
cd docker-centos-es/
</code></pre>

<h2>Build</h2>
<pre><code>docker build -t "docker-centos-es" .
</code></pre>

<h2>Run a single node</h2>
<pre><code>docker run -tdi -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" docker-centos-es
</code></pre>

<h2>Run a cluster</h2>
<pre><code>docker swarm init
docker stack deploy -c docker-compose.yml es-cluster
</code></pre>

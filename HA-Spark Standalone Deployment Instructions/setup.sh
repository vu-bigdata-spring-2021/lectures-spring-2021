#!/bin/bash

# create bridge network
docker network create sparknet

# start containers
docker run -itd --name zookeeper --network sparknet $1/bigdata-zookeeper:latest
docker run -itd --name kafka --network sparknet -p 9092:9092 --link zookeeper:zookeeper $1/bigdata-kafka:latest
docker run -itd --name master1 --network sparknet -p 8080:8080 $1/bigdata-spark:latest
docker run -itd --name master2 --network sparknet -p 8079:8080 $1/bigdata-spark:latest
docker run -itd --name worker1 --network sparknet -p 8081:8081 -v /home/ubuntu/tmp:/root/tmp $1/bigdata-spark:latest
docker run -itd --name worker2 --network sparknet -p 8082:8081 -v /home/ubuntu/tmp:/root/tmp $1/bigdata-spark:latest
docker run -itd --name client --network sparknet -v /home/ubuntu/scripts:/root/scripts -v /home/ubuntu/tmp:/root/tmp $1/bigdata-spark:latest

docker cp kafka-conf/server.properties kafka:/opt/module/kafka_2.12-2.7.0/config/
docker cp spark-conf/slaves master1:/opt/module/spark-2.4.7-bin-hadoop2.7/conf/
docker cp spark-conf/slaves master2:/opt/module/spark-2.4.7-bin-hadoop2.7/conf/
docker cp spark-conf/slaves worker1:/opt/module/spark-2.4.7-bin-hadoop2.7/conf/
docker cp spark-conf/slaves worker2:/opt/module/spark-2.4.7-bin-hadoop2.7/conf/

# configure HA Spark cluster
docker cp spark-conf/spark-env.sh master1:/opt/module/spark-2.4.7-bin-hadoop2.7/conf/
docker cp spark-conf/spark-env.sh master2:/opt/module/spark-2.4.7-bin-hadoop2.7/conf/
docker cp spark-conf/spark-env.sh worker1:/opt/module/spark-2.4.7-bin-hadoop2.7/conf/
docker cp spark-conf/spark-env.sh worker2:/opt/module/spark-2.4.7-bin-hadoop2.7/conf/

# start applications
docker exec zookeeper bin/zkServer.sh start
docker exec -d kafka bin/kafka-server-start.sh config/server.properties

# start master and two workers
docker exec master1 sbin/start-all.sh

# start standby master
docker exec master2 sbin/start-master.sh

# create topic in kafka container
#docker exec kafka bin/kafka-topics.sh --bootstrap-server 'PLAINTEXT://$(docker exec kafka hostname -I):9092' --create --topic wordcount
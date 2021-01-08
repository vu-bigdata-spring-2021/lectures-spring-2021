#!/bin/bash

docker build -f Dockerfiles/base -t $1/bigdata-base:latest .
docker push $1/bigdata-base:latest

docker build -f Dockerfiles/zookeeper -t $1/bigdata-zookeeper:latest .
docker build -f Dockerfiles/kafka -t $1/bigdata-kafka:latest .
docker build -f Dockerfiles/spark -t $1/bigdata-spark:latest .

# push to dockerhub
docker push $1/bigdata-zookeeper:latest
docker push $1/bigdata-kafka:latest
docker push $1/bigdata-spark:latest
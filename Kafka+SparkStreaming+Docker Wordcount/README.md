# Kakfa + Spark Streaming + Docker WorkCount Example

## [Instruction Video](https://www.youtube.com/watch?v=mnaiNz7PzZ4)

## Environment
- [EC2](https://console.aws.amazon.com/ec2/v2/home?region=us-east-1#InstanceTypeDetails:instanceType=t2.medium): 
    - OS: Ubuntu 18.04
    - Size: t2.medium (2CPU, 4GB RAM)
    - Volumn: 16GB
    - Security:
        - Inbound: 22, 7077, 7078, 8080, 8081, 9092, 2181
        - Outbound: all
- [Spark-2.4.7-hadoop2.7](https://apache.osuosl.org/spark/spark-2.4.7/spark-2.4.7-bin-hadoop2.7.tgz)
- [Zookeeper](https://hub.docker.com/_/zookeeper)
- [Kafka](https://hub.docker.com/r/confluent/kafka)
- [Yelp Convid-19 Dataset](https://yelp-dataset.s3.amazonaws.com/YDC14/covid_19_dataset.tgz?Signature=nY4b3YacvsMfZV03F5me8h4K%2FCM%3D&Expires=1609450692&AWSAccessKeyId=AKIAJ3CYHOIAD6T2PGKA)
![Arch](./images/arch.png)

## Step 1. Prepare Docker Environment (ssh into your ec2 instance)
```sh
sudo apt-get update && sudo apt-get install -y docker docker.io
sudo usermod -aG docker $USER # run docker without sudo
sudo reboot  # wait a few moment for instance rebooting
docker network create sparknet  # create docker bridge network
```

## Step 2. Prepare spark docker image
```sh
docker run -td --name master —network sparknet ubuntu:18.04 bash
docker exec -it master bash # get into the master container
mkdir -p /opt/module  # create directory for spark

apt-get update && apt-get install -y ssh nano net-tools lsof rsync default-jre  # install depedencies

mkdir /root/.ssh
ssh-keygen  # generate ssh key
cd .ssh
cp id_rsa.pub authorized_keys
service ssh start 
systemctl enable ssh
```

## Step 3. Download spark 2.4.7
```sh
cd /opt/module && wget https://apache.osuosl.org/spark/spark-2.4.7/spark-2.4.7-bin-hadoop2.7.tgz
tar -xvzf spark-2.4.7-bin-hadoop2.7.tgz && rm -f spark-2.4.7-bin-hadoop2.7.tgz
```

## Step 4. Prepare Spark runtime environment
```sh
cd /opt/module/spark-2.4.7-bin-hadoop2.7/conf
mv slaves.template slaves 
mv spark-env.sh.template spark-env.sh     
mv spark-defaults.conf.template spark-defaults.conf

echo "export SPARK_DAEMON_JAVA_OPTS=\"-Dspark.deploy.recoveryMode=ZOOKEEPER -Dspark.deploy.zookeeper.url=zookeeper -Dspark.deploy.zookeeper.dir=/spark\"" >> spark-env.sh  # set up HA cluster using zookeeper
echo -e "worker1\nworker2" > slaves  # communicate with workers using hostname

export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64  # export environment variables or add them into /root/.bashrc (you can use "ls -l" commend to find your JAVA_HOME path)
export PATH=$JAVA_HOME/bin:$PATH
export SPARK_HOME=/opt/module/spark-2.4.7-bin-hadoop2.7
source /root/.bashrc  # active env vars if you add them into .bashrc
exit
```

## Step 5. Commit master container as a Docker image
```sh
docker commit master spark:latest
docker tag spark:latest <your dockerhub username>/spark:latest  # optional
docker push <your dockerhub username>/spark:latest  # optional
```

## Step 6. Create all masters and workers
```sh
docker run -itd --name worker1 --network sparknet spark:latest bash
docker run -itd --name worker2 --network sparknet spark:latest bash
docker run -itd --name master2 --network sparknet -p 8081:8080 -p 7078:7077 spark:latest bash

docker rm -f master  # recreate master container
docker run -itd --name master --network sparknet -p 8080:8080 -p 7077:7077 spark:latest bash

docker exec master service ssh start  # start ssh service
docker exec master2 service ssh start
docker exec worker1 service ssh start
docker exec worker2 service ssh start
```

## Step 7. Create zookeeper container
```sh
docker run --name zookeeper --network sparknet -p 2181:2181 --restart always -d zookeeper
docker exec zookeeper apt-get update  
docker exec zookeeper apt-get install -y ssh
mkdir tmp && cd tmp  # copy .ssh directory from master to zookeeper
docker cp master:/root/.ssh .
docker cp /tmp/.ssh zookeeper:/root/

# start ssh service in zookeeper because we want to use hostname to connect zookeeper
docker exec zookeeper service ssh start  
docker exec zookeeper systemctl enable ssh
```

## Step 8. Create Kakfa container
```sh
docker run -d --name kafka -p 9092:9092 --link zookeeper:zookeeper --network sparknet -e KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://<ec2 instance elastic ip>:9092 confluent/kafka
```

## Step 9. Start Spark
```sh
docker exec -it master bash
cd /opt/spark/sbin
./start-all.sh  # start master, worker1, worker2

docker exec -it master2 bash
cd /opt/spark/sbin
./start-master.sh  # start master2 as standby master
```

## Step 10. Run example
```sh
## 10.1 replace the PUBLIC_IP in the constants.py as your own ec2 instance elastic ip
## 10.2 download the yelp covid-19 dataset
pip3 install -r requirements.txt # install python dependencies
python3 producer.py   # start producer
python3 client.py   # start clientq
```
You can check spark cluster and application status on  
- Primary Master: http://\<ec2 public ip\>:8080/
- Standby Master: http://\<ec2 public ip\>:8081/

![master](./images/master.png)
![master-standby](./images/master-standby.png)
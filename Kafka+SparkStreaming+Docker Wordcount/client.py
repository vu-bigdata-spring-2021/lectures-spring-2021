
import os
import json
import findspark
from pyspark import SparkContext, SparkConf
from pyspark.streaming import StreamingContext
from pyspark.streaming.kafka import KafkaUtils
from constants import *

if __name__ == '__main__':
    os.environ["JAVA_HOME"] = "/usr/lib/jvm/java-11-openjdk-amd64"
    os.environ["SPARK_HOME"] = "%s/spark-2.4.7-bin-hadoop2.7" % os.getenv('HOME')
    os.environ["PYTHONPATH"] = "%s/python/lib/py4j-0.10.7-src.zip:/usr/bin/python3" % os.getenv('SPARK_HOME')
    os.environ['PYSPARK_SUBMIT_ARGS'] = '--packages org.apache.spark:spark-streaming-kafka-0-8_2.11:2.4.7 pyspark-shell'

    findspark.init()

    conf = SparkConf().setAppName("spark streaming app").setMaster("spark://%s:7077,%s:7078" % (PUBLIC_IP, PUBLIC_IP))

    # Create Spark context
    sc = SparkContext(conf=conf)
    sc.setLogLevel("WARN")

    # Create Spark Streaming context
    ssc = StreamingContext(sparkContext=sc, batchDuration=3)

    # Connect to Kafka
    kafkaStream = KafkaUtils.createDirectStream(ssc=ssc,
                                                kafkaParams={"metadata.broker.list": '%s:9092' % PUBLIC_IP},
                                                topics=[TOPIC])

    # Parse the inbound message as json
    parsed = kafkaStream.map(lambda v: json.loads(v[1]))

    # Get merchants that provide delivery or takeaway services
    open_business_dstream = parsed.filter(lambda sample: sample['delivery or takeout'] == "TRUE" and sample['Covid Banner'] != "FALSE")

    # Sort the merchant by the amount of words in the Covid Banner field
    covid_banner_words_sorted_dstream = open_business_dstream\
        .flatMap(lambda sample: sample['Covid Banner'].split(" "))\
        .map(lambda word: (word, 1)) \
        .reduceByKey(lambda a, b: a + b, 1)

    top5_words_in_covid_banner = covid_banner_words_sorted_dstream\
        .transform(lambda rdd: rdd.sortBy(lambda x: -x[1])).pprint(5)

    # Start the streaming context
    ssc.start()
    ssc.awaitTermination()


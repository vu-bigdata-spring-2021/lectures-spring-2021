import time
from kafka import KafkaProducer
from constants import *

producer = KafkaProducer(bootstrap_servers='%s:9092' % PUBLIC_IP)

for i in range(10):
    with open('yelp_academic_dataset_covid_features.txt') as f:
        line_count = 0
        while True:
            line = f.readline()
            if not line:
                break
            producer.send(topic=TOPIC, value=line.encode(), partition=0)
            print('line %d: %s' % (line_count, line))
            line_count += 1
    print('===== round%d =====' % i)

producer.close()
print('done')

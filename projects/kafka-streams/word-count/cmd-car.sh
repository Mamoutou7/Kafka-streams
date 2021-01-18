# create input topic with one partition to get full ordering
bin/kafka-topics.sh --create --topic --replication-fatcor 1 --partitions 1 car-colour-input --bootstrap-server localhost:9092

# create intermediary log compact topic
bin/kafka-topics.sh --create --topic --replication-factor 1 --partitions 1 car-keys-and-colours --config cleanup.policy=compact --bootstrap-server localhost:9092


# create output log compact topic
bin/kafka-topics.sh --create --topic --replication-factor 1 --partitions 1 car-colour-output --config cleanup.policy=compact --bootstrap-server localhost:9092




# launch a Kafka consumer
bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 \
    --topic car-colour-output \
    --from-beginning \
    --formatter kafka.tools.DefaultMessageFormatter \
    --property print.key=true \
    --property print.value=true \
    --property key.deserializer=org.apache.kafka.common.serialization.StringDeserializer \
    --property value.deserializer=org.apache.kafka.common.serialization.LongDeserializer


# then produce data to it
bin/kafka-console-producer.sh --broker-list localhost:9092 --topic car-colour-input


# Connect Debezium connector to CloudSQL for MySQL

![0](/images/13.png)

### Check that this step has been completed before STAR
- JSON [files](https://github.com/thunchanokbow/Cinema-Data-Streaming-with-Kafka/blob/main/mysql-source.json) configuration: **mysql-source.json**   
- Github Repository [HTTPS](https://github.com/thunchanokbow/Cinema-Data-Streaming-with-Kafka.git).
- Docker-compose [file](https://github.com/thunchanokbow/Cinema-Data-Streaming-with-Kafka/blob/kafka/docker-compose.yml).
- Run docker compose on VM Compute Engine.
- Setting VPC firewall rules port.
- Setting networks for connecting to Cloud SQL instances.
  
![0](/images/11.png)

To connect debezium connector to Cloud SQL for MySQL, follow these steps: 
1. Go to the **Compute Engine** page, click **SSH**.
2. Check if you have intsalled **Curl** on your VM.
```
curl --version
```
3. Run Curl Command create **source connector**.
```
curl -i -X POST -H "Accept: application/json" -H "Content-Type: application/json" http://localhost:8083/connectors/ -d @mysql-source.json
```
![0](/images/14.png)
![0](/images/15.png)

# Connect JDBC sink connector to CloudSQL for MySQL.
Once the **source connector** is up and running, you will see the **topic** displayed on the **control center** page. If you want to **stream data** from the source database to the **destination database**, you need to use the **JDBC sink connector**.

![0](/images/16.png)

### Check that this step has been completed before STAR
- JSON [files](https://github.com/thunchanokbow/Cinema-Data-Streaming-with-Kafka/blob/main/mysql-sink-kafka.json) configuration: **mysql-sink-kafka.json**
- Run docker compose on VM Compute Engine.
- Setting VPC firewall rules port.
- Setting networks for connecting to Cloud SQL instances.
- Connetors including **JDBC MySQL driver**.

![0](/images/17.png)

To connect JDBC sink connector to CloudSQL for MySQL, follow these steps:
1. Go to the **Compute Engine** page, click **SSH**.
2. Run Curl Command create **sink connector**.
```
curl -i -X POST -H "Accept: application/json" -H "Content-Type: application/json" http://localhost:8083/connectors/ -d @mysql-sink-kafka.json
```
![0](/images/18.png)

Once you start the JDBC sink connector, it will automatically begin streaming data from the source database to the destination database.
For more information about JDBC drivers.[Here](https://docs.confluent.io/kafka-connectors/jdbc/current/jdbc-drivers.html)


# How to fix error message "No suitable driver found"

If the JDBC sink connector is still **not working** and there is no **mysql-sink-kafka** on the **Confluent page** in connect list, it might be because the driver is installed incorrectly or the path is wrong.

To fix error message, follow these steps:
1. Go to the **Compute Engine** page, click **SSH**.
2. Check Docker container **logs**.
```
sudo docker logs connect | grep mysql-sink-kafka
```
3. You should have received results in the logs similar to this example.
```
[2024-01-02 04:08:23,241] ERROR WorkerSinkTask{id=mysql-sink-kafka-0}
Task threw an uncaught and unrecoverable exception.
Task is being killed and will not recover until manually restarted.
Error: java.sql.SQLException: No suitable driver found for
jdbc:mysql://35.241.94.127:3306/demo?nullCatalogMeansCurrent=true&autoReconnect=true&useSSL=false
(org.apache.kafka.connect.runtime.WorkerSinkTask)
```
4. Make sure that the **JDBC driver** has been installed in the Docker container.
- Enter an interactive shell session inside a **connect** docker container. 
```
sudo docker exec -it connect bash  
```
- To list the contents of a **connect** docker container directory.
```
ls -l /usr/share/confluent-hub-components/confluentinc-kafka-connect-jdbc
```
5. There should be a `mysql-connector-java-8.0.13.jar` in the directory like this example.
![0](/images/19.png)

6. Add volume configuration to `docker-compose.yml` like this. 
```
  connect:
    image: cnfldemos/cp-server-connect-datagen:0.5.3-7.1.0
    hostname: connect
    container_name: connect
    depends_on:
      - broker
      - schema-registry
    ports:
      - "8083:8083"
    environment:
      CONNECT_BOOTSTRAP_SERVERS: "broker:29092"
      CONNECT_REST_ADVERTISED_HOST_NAME: connect
      CONNECT_GROUP_ID: compose-connect-group
      CONNECT_CONFIG_STORAGE_TOPIC: docker-connect-configs
      CONNECT_CONFIG_STORAGE_REPLICATION_FACTOR: 1
      CONNECT_OFFSET_FLUSH_INTERVAL_MS: 10000
      CONNECT_OFFSET_STORAGE_TOPIC: docker-connect-offsets
      CONNECT_OFFSET_STORAGE_REPLICATION_FACTOR: 1
      CONNECT_STATUS_STORAGE_TOPIC: docker-connect-status
      CONNECT_STATUS_STORAGE_REPLICATION_FACTOR: 1
      # CONNECT_KEY_CONVERTER: org.apache.kafka.connect.storage.StringConverter
      CONNECT_KEY_CONVERTER: io.confluent.connect.avro.AvroConverter
      CONNECT_KEY_CONVERTER_SCHEMA_REGISTRY_URL: "http://schema-registry:8081"
      CONNECT_VALUE_CONVERTER: io.confluent.connect.avro.AvroConverter
      CONNECT_VALUE_CONVERTER_SCHEMA_REGISTRY_URL: "http://schema-registry:8081"
      # CLASSPATH required due to CC-2422
      CLASSPATH: /usr/share/java/monitoring-interceptors/monitoring-interceptors-7.2.1.jar
      CONNECT_PRODUCER_INTERCEPTOR_CLASSES: "io.confluent.monitoring.clients.interceptor.MonitoringProducerInterceptor"
      CONNECT_CONSUMER_INTERCEPTOR_CLASSES: "io.confluent.monitoring.clients.interceptor.MonitoringConsumerInterceptor"
      CONNECT_PLUGIN_PATH: "/usr/share/java,/usr/share/confluent-hub-components,/usr/local/share/kafka/plugins"
      CONNECT_LOG4J_LOGGERS: org.apache.zookeeper=ERROR,org.I0Itec.zkclient=ERROR,org.reflections=ERROR
    command:
      - bash
      - -c
      - |
        echo "Installing Connector"
        confluent-hub install --no-prompt debezium/debezium-connector-mysql:1.7.0
        # confluent-hub install --no-prompt confluentinc/kafka-connect-elasticsearch:11.1.3
        # confluent-hub install --no-prompt neo4j/kafka-connect-neo4j:2.0.0
        confluent-hub install --no-prompt confluentinc/kafka-connect-jdbc:10.5.2
        #
        echo "Launching Kafka Connect worker"
        /etc/confluent/docker/run &
        #
        sleep infinity
    volumes:
      - ./connectors:/usr/share/confluent-hub-components
      - ./mysql-connector-java-8.0.13.jar:/usr/share/confluent-hub-components/confluentinc-kafka-connect-jdbc/mysql-connector-java-8.0.13.jar

```

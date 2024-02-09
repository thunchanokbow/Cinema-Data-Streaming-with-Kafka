# Connect Debezium connector to CloudSQL for MySQL

![0](/images/13.png)

### Check that this step has been completed before STAR
- JSON files configuration: **mysql-source.json**   
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
- JSON files configuration: **mysql-sink-kafka.json**
- Run docker compose on VM Compute Engine.
- Setting VPC firewall rules port.
- Setting networks for connecting to Cloud SQL instances.
- Connetors including **JDBC MySQL driver**.- 

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

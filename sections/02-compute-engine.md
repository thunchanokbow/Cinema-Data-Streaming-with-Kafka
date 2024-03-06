# Compute Engine

Compute Engine is a computing and hosting service that lets you **create and run virtual machines** on Google infrastructure. 

- [Create VM Instances](02-compute-engine.md#Create-VM-Instances).<br> 
- [Install Git and Docker on a new VM](02-compute-engine.md#Install-Git-and-Docker-on-a-new-VM).<br>
- [Upload YAML files to VM ](02-compute-engine.md#Upload-YAML-files-to-VM).<br>
- [Get Confluent Control Center](02-compute-engine.md#Get-Confluent-Control-Center).<br>

![0](/images/07.png)

## Create VM Instances

![0](/images/08.png)

To create and start a VM instance, follow these steps:
1. Go to the **VM instances** page. [Here](https://console.cloud.google.com/projectselector2/compute/instances?_ga=2.1051961.984664577.1707279696-731346549.1689819688&_gac=1.57318104.1705473038.CjwKCAiA75itBhA6EiwAkho9e44wKFEVt0zpyn3yKBtkQVigcqv9l2pn-XhcAq4CQhLZTiajuYk3phoCbYYQAvD_BwE&supportedpurview=project).
2. Click **Create instance**.
3. For **Name**, enter a name for your VM instances.
4. For **Region** and **Zone**, choose where you want the VM instance to reside: `asia-east2`.
5. Select a **Machine configuration** for your VM: `e2-standard-8 (8 vCPU, 4 core, 32 GB memory)`.
6. In the **Boot disk** section, click **CHANGE**: Size `300 GB`.
7. In the **Identity and API Access** section, select **Allow full access to all Cloud APIs**.
8. In the **Firewall** section, select all.

For more information about create and start a VM instance.[Here](https://cloud.google.com/compute/docs/instances/create-start-instance)

![0](/images/09.png)

9. To create **VPC firewall rules**:
- Go to the **Firewall policies** page. [Here](https://console.cloud.google.com/net-security/firewall-manager/firewall-policies/list?_ga=2.71910811.984664577.1707279696-731346549.1689819688&_gac=1.156871241.1705473038.CjwKCAiA75itBhA6EiwAkho9e44wKFEVt0zpyn3yKBtkQVigcqv9l2pn-XhcAq4CQhLZTiajuYk3phoCbYYQAvD_BwE)
- Enter a **Name** for the firewall rule.
- Specify the **Targets** of the rule: **All instances in the network**.
- Specify the **Source filter**, select **IPv4 ranges**: `0.0.0.0/0`.
- Specify the **Destination filter**, select **IPv4 ranges**: `0.0.0.0/0`.
- Define the **Protocols and ports**, select **TCP**: `9021`.
- Click **Create**.<br>


Make sure that all necessary ports have been added to the VPC firewall rules, including the ports used in the **docker-compose**.<br>
For more information about create VPC firewall rules.[Here](https://cloud.google.com/firewall/docs/using-firewalls#rules-for-common-use-cases)

![0](/images/10.png)

10. Authorized **networks** settings for connecting to Cloud SQL instances that use **IP addresses**.
- From the **Compute Engine** navigation menu, select **VM instances**.
- Scroll down to the **Network interfaces** to this instance and copy the **External IP address**.
- Go to the **Cloud SQL**, select **Connections**.
- Click the **Network** tab.
- Click **Add a network**.
- In the **Name** field, enter a name for the **External IP address**.
- Enter the **External IP address**: `35.220.210.38`.
- Click **Done**.
- Click **Save**.
   
![0](/images/11.png)

## Install Git and Docker on a new VM. 

### Check that this step has been completed before START
- JSON files configuration: **mysql-source.json, mysql-sink-kafka.json**. 
- Github Repository [HTTPS](https://github.com/thunchanokbow/Cinema-Data-Streaming-with-Kafka.git).
- Docker-compose [file](https://github.com/thunchanokbow/Cinema-Data-Streaming-with-Kafka/blob/kafka/docker-compose.yml).
- Connetors including **JDBC MySQL driver**.

#### mysql-source.json

```
{
  "name": "mysql-source-kafka",
  "config": {
    "connector.class": "io.debezium.connector.mysql.MySqlConnector",
    "database.hostname": "PUBLIC_IP_ADDRESS",
    "database.port": "3306",
    "database.user": "root",
    "database.password": "PASSWORD",
    "database.server.name": "SERVER_NAME",
    "table.whitelist": "demo.movies",
    "database.history.kafka.bootstrap.servers": "broker:9092",
    "database.history.kafka.topic": "movies",
    "decimal.handling.mode": "double",
    "include.schema.changes": "true",
    "key.converter": "io.confluent.connect.avro.AvroConverter",
    "value.converter": "io.confluent.connect.avro.AvroConverter",
    "key.converter.schema.registry.url": "http://schema-registry:8081",
    "value.converter.schema.registry.url": "http://schema-registry:8081"
  }
}
```

#### mysql-sink-kafka.json

```
{
    "name": "mysql-sink-kafka",
    "config": {
      "connector.class": "io.confluent.connect.jdbc.JdbcSinkConnector",
      "task.max": "1",
      "topics": "SERVER_NAME.demo.movies",
      "key.converter": "io.confluent.connect.avro.AvroConverter",
      "value.converter": "io.confluent.connect.avro.AvroConverter",
      "key.converter.schema.registry.url": "http://schema-registry:8081",
      "value.converter.schema.registry.url": "http://schema-registry:8081",
      "transforms": "unwrap",
      "transforms.unwrap.type": "io.debezium.transforms.ExtractNewRecordState",
      "transforms.unwrap.drop.tombstones": "false",
      "key.converter.schemas.enable": "true",
      "errors.tolerance": "all",
      "errors.log.include.messages": true,
      "connection.attempts": "6",
      "connection.backoff.ms": "1000",
      "connection.url": "jdbc:mysql://PUBLIC_IP_ADDRESS:3306/demo?nullCatalogMeansCurrent=true&autoReconnect=true&useSSL=false",
      "connection.user": "root",
      "connection.password": "PASSWORD",
      "dialect.name": "MySqlDatabaseDialect",
      "insert.mode": "upsert",
      "delete.enabled" : "true",
      "batch.size": "2",
      "table.name.format": "movies",
      "table.whitelist": "demo.movies",
      "pk.mode": "record_key",
      "pk.fields": "movie_id",
      "auto.create": "true",
      "auto.evolve": "true",
      "db.timezone": "Asia/Bangkok"
    }
  }

```
![0](/images/07.png)

To intstall Git and Docker, follow these steps: 
1. Go to the **Compute Engine** page, click **SSH**.
2. Install **Git** on Cumpute Engine.
```
sudo apt-get install git
```
3. Install **Docker Product** on Compute Engine.
```
curl -fsSL https://get.docker.com | sh
```
4. Install **Docker Compose** on Compute Engine.
```
sudo apt-get install docker-compose
```

## Upload YAML files to VM. 
To upload files to VM Compute Engine, follow these steps:
1. Open the Github repository.
2. Click the **Clone** button.
3. Copy the provided **HTTPS**, which typically starts with `https://`.
4. Clone **Github Repository** to VM Compute Engine using **SSH**.
```
git clone <HTTPS_Links>
```

![0](/images/12.png)

## Get Confluent Control Center. 
To get confluent control center, follow these steps:
1. Running the `docker-compose.yml`.
```
sudo docker compose up -d
```
2. To list all docker containers.
```
sudo docker ps -a
```
3. Go to the **Compute Engine** page, copy **External IP Address**.
4. Enter **External IP Address** and **Control Center port** in address bar : `35.220.210.38:9021` 

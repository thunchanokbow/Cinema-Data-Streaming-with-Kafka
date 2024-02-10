# Cinema Data Streaming with Kafka

Build a data synchronization system between databases with **Kafka** that implements **change data capture (CDC)** to ingest binlogs from the source database, process them, and write them to the target database correctly, completely, and instantly in real time.

## Project Overview
![0](/images/01.png)

## Contents (Coming Soon)
[Cloud SQL for MySQL database](sections/01-cloud-sql-for-mysql-database.md).<br>
- [Hosting MySQL on Cloud SQL](sections/01-cloud-sql-for-mysql-database.md#Hosting-MySQL-on-Cloud-SQL).<br> 
- [Connect via DBeaver](sections/01-cloud-sql-for-mysql-database.md#Connect-via-DBeaver).<br>

[Compute Engine](sections/02-compute-engine.md).<br> 
- [Create VM Instances](sections/02-compute-engine.md#Create-VM-Instances).<br> 
- [Install Git and Docker on a new VM](sections/02-compute-engine.md#Install-Git-and-Docker-on-a-new-VM).<br>
- [Upload YAML files to VM ](sections/02-compute-engine.md#Upload-YAML-files-to-VM).<br>
- [Get Confluent Control Center](sections/02-compute-engine.md#Get-Confluent-Control-Center).<br>

[Connect Debezium connector to Cloud SQL for MySQL](sections/03-connect-debezium-connector-to-cloud-sql-for-mysql.md#Connect-Debezium-connector-to-Cloud-SQL-for-MySQL).  
[Connect JDBC sink connector to CloudSQL for MySQL](sections/03-connect-debezium-connector-to-cloud-sql-for-mysql.md#Connect-JDBC-sink-connector-to-CloudSQL-for-MySQL).<br> 
- [How to fix error message "No suitable driver found"](sections/03-connect-debezium-connector-to-cloud-sql-for-mysql.md#Connect-JDBC-sink-connector-to-CloudSQL-for-MySQL)<br> 





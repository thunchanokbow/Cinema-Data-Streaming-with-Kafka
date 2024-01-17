[17 Jan 2023]

Google Cloud Platform Provision

1. Create CloudSQL / MySQL
- New Database on Cloud SQL
>>Video
"https://www.youtube.com/watch?v=BQlQ-BTMR1U"
>>Doc
"https://cloud.google.com/sql/docs/mysql/create-instance"

2. Create Compute Engine 
- Clone Repository / GitHub 
- Docker Compose / YAML
>>Running image from Repository
"docker compose up -d" 
>>Double check 
"docker ps -a"
- Open UI / VM / Network interfaces / COPY "External IP Address" 

3. Download DBeaver
- Install DBeaver
>>Video
"https://www.youtube.com/watch?v=LEx96-CkB1Q&pp=ygUWaW5zdGFsbCBkYmVhdmVyIG9uIG1hYw%3D%3D"
- Connect DBeaver to Cloud SQL for MySQL
>>Video
"https://www.youtube.com/watch?v=GwG6QgDL5yA&list=PLZPa3uRAtggBk_03nPcu0XVu3Hd2xaWsJ&index=1&pp=gAQBiAQB"
- Create "demo" database / moives.sql

4. Connect Debezium to Cloud SQL for MySQL 

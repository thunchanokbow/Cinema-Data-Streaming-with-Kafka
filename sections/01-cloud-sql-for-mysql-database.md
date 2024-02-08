# Cloud SQL for MySQL database.

Cloud SQL is a fully managed relational database service for MySQL, PostgreSQL, and SQL Server. This frees you from database administration tasks so that you have more time to manage your data.

- [Hosting MySQL on Cloud SQL](01-cloud-sql-for-mysql-database.md#).<br>
- [Connect via DBeaver](01-cloud-sql-for-mysql-database.md#Connect-via-DBeaver).<br> 

![0](/images/02.png)

## Hosting MySQL on Cloud SQL

![0](/images/03.png)

To create a Cloud SQL for MySQL instance, follow these steps:
1. In the Google Cloud console, go to the **Cloud SQL Instances** page.
2. Click **Create instance**.
3. On the **Choose your database engine** panel of the **Create an instance** page, click **Choose MySQL**.
4. Enter an **ID** for your instance.
5. Set a password for the **root** user.
6. Select the **database version** for your instance: **MySQL 5.7**.
7. In the **Choose region and zonal availability** section, select the region and zone for your instance: **asia-east2** (it will use composer in HongKong).
![0](/images/04.png)

8. Authorized **networks** settings for connecting to Cloud SQL instances that use **IP addresses**.
- From the SQL navigation menu, select **Connections**.
- Click the **Network** tab.
- Select the **Public IP** checkbox.
- Click **Add a network**.
- In the **Name** field, enter a name for the **New network**.
- Enter the **public IPv4 address** or **address range** from which you want to allow connections.
- Click **Done**.
- Click **Save**.

For more information about create a Cloud SQL for MySQL instance.[Here](https://cloud.google.com/sql/docs/mysql/create-instance)

## Connect via DBeaver

![0](/images/05.png)

To connect via DBeaver, follow these steps:
1. From the SQL navigation menu, select **Overview**.
2. Scroll down to the **Connect to this instance** and copy the **Public IP address**.

![0](/images/06.png)

3. Open **DBeaver**, select **MySQL** database.
4. Click **Next**.
5. On **MySQL connection settings** page, enter **Public IP address** of the Cloud SQL for MySQL.
6. In the **Port** field, enter **3306**.
7. Enter **Username** and **Password**.
8. Click **Finish**.

For more information about DBeaver.[Here](https://dbeaver.com/docs/dbeaver/GCP-Credentials/)

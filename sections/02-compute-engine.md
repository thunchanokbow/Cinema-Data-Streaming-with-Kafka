# Compute Engine

Compute Engine is a computing and hosting service that lets you **create and run virtual machines** on Google infrastructure. 

- [Create VM Instances](sections/02-compute-engine.md#Create-VM-Instances).<br> 
- [Install Git and Docker on a new VM](sections/02-compute-engine.md).<br>
- [Upload YAML files to VM ](sections/02-compute-engine.md).<br>
- [Get Confluent Control Center](sections/02-compute-engine.md).<br>

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
   
## Install Git and Docker on a new VM

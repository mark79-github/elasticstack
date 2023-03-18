# DevOps - Containerization, CI/CD &amp; Monitoring - January 2023 - SoftUni

## Monitoring with Elastic Stack

### The whole process is fully automated

1. **Creating Vagrantfile which creates three virtual machine with the following configuration:**
    - Server
      - Box: **`shekeriev/centos-stream-9`**
      - Host names: **`server.martin.bg`**
      - Private network with dedicated IPs: **`192.168.34.201`**
      - Provisioning via provided bash scripts: [**`setup-hosts.sh`**](setup-hosts.sh), [**`setup-update.sh`**](setup-update.sh),[**`setup-firewall.sh`**](setup-firewall.sh), [**`setup-docker.sh`**](setup-docker.sh) and [**`setup-elasticstack.sh`**](setup-elasticstack.sh)
      - Shared folder configuration: **`elasticstack/`** -> **`/vagrant/elasticstack`**
      - Set virtual machine memory size: **`4096`**
      - Set virtual machine cpu: **`2`**
      - Set virtual machine GUI: **`false`**
    - Centos
      - Box: **`shekeriev/centos-stream-9`**
      - Host names: **`centos.martin.bg`**
      - Private network with dedicated IPs: **`192.168.34.202`**
      - Provisioning via provided bash scripts: [**`setup-hosts.sh`**](setup-hosts.sh), [**`setup-update.sh`**](setup-update.sh),  [**`setup-firewall.sh`**](setup-firewall.sh), [**`setup-beat.sh`**](setup-beat.sh)
      - Shared folder configuration: **`"beats/"`** -> **`"/vagrant/beats"`**
      - Set virtual machine memory size: **`1024`**
      - Set virtual machine cpu: **`1`**
      - Set virtual machine GUI: **`false`**
    - Ubuntu
      - Box: **`shekeriev/ubuntu-20-04-server`**
      - Host names: **`ubuntu.martin.bg`**
      - Private network with dedicated IPs: **`192.168.34.203`**
      - Provisioning via provided bash scripts: [**`setup-hosts.sh`**](setup-hosts.sh), [**`setup-update.sh`**](setup-update.sh),  [**`setup-firewall.sh`**](setup-firewall.sh), [**`setup-beat.sh`**](setup-beat.sh)
      - Shared folder configuration: **`"beats/"`** -> **`"/vagrant/beats"`**
      - Set virtual machine memory size: **`1024`**
      - Set virtual machine cpu: **`1`**
      - Set virtual machine GUI: **`false`**
    - Create after trigger event to create an index pattern in Kibana using REST API
    - Create another after trigger event to open default browser to view created Kibana dataviews at [**`http://192.168.34.201:5601/app/management/kibana/dataViews`**](http://192.168.34.201:5601/app/management/kibana/dataViews)
2. **Sequence of actions:**
    - Install docker on server:
    - Install elasticstack on server:
        - Limit on mmap counts equal to **`262144`**
        - Build and run docker images in shared folder with docker compose
        - Waiting for Elasticsearch to be up and running
    - Setup beat on centos:
        - Download and install beat file
        - Copy custom yml configuration file for the beat
        - Test custom configuration
        - Installing beat template in Elasticsearch
        - Start and enable the beat service
    - Setup beat on ubuntu:
        - Download and install beat file
        - Copy custom yml configuration file for the beat
        - Test custom configuration
        - Installing beat template in Elasticsearch
        - Start and enable the beat service
    - Using REST API to create an index pattern in Kibana
3. **The result can be seen at [**`http://192.168.34.201:5601/app/management/kibana/dataViews`**](http://192.168.34.201:5601/app/management/kibana/dataViews)**

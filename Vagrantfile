# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
    
  config.ssh.insert_key = false

  config.vm.define "server" do |server|
    server.vm.box="shekeriev/centos-stream-9"
    server.vm.hostname = "server.martin.bg"
    server.vm.provider :virtualbox do |vb|
        vb.gui = false
        vb.memory = 4096
        vb.cpus = 2
    end
    server.vm.network "private_network", ip: "192.168.34.201"
    server.vm.synced_folder "elasticstack/", "/vagrant/elasticstack"
    server.vm.provision "shell", path: "setup-hosts.sh"
    server.vm.provision "shell", path: "setup-update.sh"
    server.vm.provision "shell", path: "setup-firewall.sh"
    server.vm.provision "shell", path: "setup-docker.sh"
    server.vm.provision "shell", path: "setup-elasticstack.sh"
  end

  config.vm.define "centos" do |centos|
    centos.vm.box="shekeriev/centos-stream-9"
    centos.vm.hostname = "centos.martin.bg"
    centos.vm.provider :virtualbox do |vb|
        vb.gui = false
        vb.memory = 1024
        vb.cpus = 1
    end
    centos.vm.network "private_network", ip: "192.168.34.202"
    centos.vm.synced_folder "beats/", "/vagrant/beats"
    centos.vm.provision "shell", path: "setup-hosts.sh"
    centos.vm.provision "shell", path: "setup-update.sh"
    centos.vm.provision "shell", path: "setup-beats.sh", :args => "metricbeat filebeat heartbeat auditbeat"
  end

  config.vm.define "ubuntu" do |ubuntu|
    ubuntu.vm.box="shekeriev/ubuntu-20-04-server"
    ubuntu.vm.hostname = "ubuntu.martin.bg"
    ubuntu.vm.provider :virtualbox do |vb|
        vb.gui = false
        vb.memory = 1024
        vb.cpus = 1
    end
    ubuntu.vm.network "private_network", ip: "192.168.34.203"
    ubuntu.vm.synced_folder "beats/", "/vagrant/beats"
    ubuntu.vm.provision "shell", path: "setup-hosts.sh"
    ubuntu.vm.provision "shell", path: "setup-update.sh"
    ubuntu.vm.provision "shell", path: "setup-beats.sh", :args => "metricbeat filebeat heartbeat auditbeat"
  end

  config.trigger.after :up do |trigger|
    trigger.only_on ="ubuntu"
    trigger.info = "*** Create an index pattern in Kibana using REST API  ..."
    trigger.run = {inline: "vagrant ssh -c 'cd /vagrant/beats && bash ./setup-dataview.sh metricbeat filebeat heartbeat auditbeat' ubuntu"}     
  end

  config.trigger.after :up do |trigger|
    trigger.only_on ="ubuntu"
    trigger.info = "*** Open default browser ..."
    if Vagrant::Util::Platform.windows?
      trigger.run = {inline: "start http://192.168.34.201:5601/app/management/kibana/dataViews"}
    end
    if Vagrant::Util::Platform.linux?
      trigger.run = {inline: "bash -c 'xdg-open http://192.168.34.201:5601/app/management/kibana/dataViews'"}
    end
    if Vagrant::Util::Platform.darwin?
      trigger.run = {inline: "open http://192.168.34.201:5601/app/management/kibana/dataViews"}
    end
  end
end

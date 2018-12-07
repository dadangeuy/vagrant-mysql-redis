Vagrant.configure("2") do |config|

  config.vm.define "mysql" do |db|
    db.vm.hostname = "mysql"
    db.vm.box = "bento/ubuntu-18.04"
    db.vm.network "private_network", ip: "192.168.33.20"
    db.vm.provider "virtualbox" do |vb|
      vb.name = "mysql"
      vb.gui = false
      vb.memory = "512"
      vb.cpus = 2
      vb.customize [
        "modifyvm", :id,
        "--ioapic", "on",
        "--cpuexecutioncap", "50",
        "--natdnshostresolver1", "on",
        "--natdnsproxy1", "on"
      ]
    end
    db.vm.provision "shell", privileged: false, path: "provision/mysql/master.mysql.sh"
    db.vm.provision "shell", privileged: false, path: "dataset/import-dataset.sh"
  end

  (1..2).each do |i|
    config.vm.define "mysql-slave-#{i}" do |db|
      db.vm.hostname = "mysql-slave-#{i}"
      db.vm.box = "bento/ubuntu-18.04"
      db.vm.network "private_network", ip: "192.168.33.2#{i}"
      db.vm.provider "virtualbox" do |vb|
        vb.name = "mysql-slave-#{i}"
        vb.gui = false
        vb.memory = "512"
        vb.cpus = 2
        vb.customize [
          "modifyvm", :id,
          "--ioapic", "on",
          "--cpuexecutioncap", "50",
          "--natdnshostresolver1", "on",
          "--natdnsproxy1", "on"
        ]
      end
      db.vm.provision "shell", privileged: false, path: "provision/mysql/slave#{i}.mysql.sh"
    end
  end

  config.vm.define "redis" do |db|
    db.vm.hostname = "redis"
    db.vm.box = "bento/ubuntu-18.04"
    db.vm.network "private_network", ip: "192.168.33.30"
    db.vm.provider "virtualbox" do |vb|
      vb.name = "redis"
      vb.gui = false
      vb.memory = "512"
      vb.cpus = 2
      vb.customize [
        "modifyvm", :id,
        "--ioapic", "on",
        "--cpuexecutioncap", "50",
        "--natdnshostresolver1", "on",
        "--natdnsproxy1", "on"
      ]
    end
    db.vm.provision "shell", privileged: false, path: "provision/redis/master.redis.sh"
  end

  (1..2).each do |i|
    config.vm.define "redis-slave-#{i}" do |db|
      db.vm.hostname = "redis-slave-#{i}"
      db.vm.box = "bento/ubuntu-18.04"
      db.vm.network "private_network", ip: "192.168.33.3#{i}"
      db.vm.provider "virtualbox" do |vb|
        vb.name = "redis-slave-#{i}"
        vb.gui = false
        vb.memory = "512"
        vb.cpus = 2
        vb.customize [
          "modifyvm", :id,
          "--ioapic", "on",
          "--cpuexecutioncap", "50",
          "--natdnshostresolver1", "on",
          "--natdnsproxy1", "on"
        ]
      end
      db.vm.provision "shell", privileged: false, path: "provision/redis/slave.redis.sh"
    end
  end
end

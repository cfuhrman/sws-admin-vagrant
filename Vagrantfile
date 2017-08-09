# -*- mode: ruby -*-
# vi: set ft=ruby :

# By default, this Vagrantfile will use 'virtualbox' as the provider.  To change
# this, set VAGRANT_DEFAULT_PROVIDER environment variable to your desired
# provider (e.g., 'vmware_fusion' or 'vmware_workstation')

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
VAGRANTFILE_API_VERSION = "2"

Vagrant.require_version ">= 1.4.3"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  #config.vm.box = "centos/7"
  config.vm.box = "bento/centos-7.3"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"
  config.vm.synced_folder ".", "/vagrant", type: "nfs"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL

  if ENV["KONG_PATH"]
    source = ENV["KONG_PATH"]
  elsif File.directory?("./kong")
    source = "./kong"
  elsif File.directory?("../kong")
    source = "../kong"
  else
    source = ""
  end

  if ENV["KONG_PLUGIN_PATH"]
    plugin_source = ENV["KONG_PLUGIN_PATH"]
  elsif File.directory?("./kong-plugin")
    plugin_source = "./kong-plugin"
  elsif File.directory?("../kong-plugin")
    plugin_source = "../kong-plugin"
  else
    plugin_source = ""
  end

  if ENV['KONG_VB_MEM']
    memory = ENV["KONG_VB_MEM"]
  else
    memory = 2048
  end

  env_provider = ENV["VAGRANT_DEFAULT_PROVIDER"]

  config.vm.provider :env_provider do |vb|
    vb.name = "vagrant_swsadmin"
    vb.memory = "2048"
  end

  #config.vm.box = "ubuntu/trusty64"

  config.vm.network :forwarded_port, guest: 8000, host: 8000
  config.vm.network :forwarded_port, guest: 8001, host: 8001
  config.vm.network :forwarded_port, guest: 8443, host: 8443
  config.vm.network :forwarded_port, guest: 8444, host: 8444
  # config.vm.network "private_network", type: "dhcp"
  #config.vm.network :private_network, ip: '192.168.44.43'
  config.vm.network :private_network, ip: '192.168.42.43'

  #
  # Host manager for local hosts file
  #
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = true
  config.vm.define 'default' do |node|
    node.vm.hostname = 'admin-dev.corp.shipwire.com'
    node.hostmanager.aliases = %w(
      kong.admin-dev.corp.shipwire.com
      cdb.admin-dev.corp.shipwire.com
      redis.admin-dev.corp.shipwire.com
    )
  end

  #config.vm.provision "shell", path: "provision.sh"
  config.vm.provision :chef_solo do |chef|

    chef.add_recipe "yum-epel"
    chef.add_recipe "standard"
    # chef.add_recipe "nginx"
#    chef.add_recipe "cassandra-platform"
    #chef.add_recipe "postgresql::server" #seems kong needs postgres to start
    chef.add_recipe "standard::cassandra"
    chef.add_recipe "standard::kong"
#    chef.add_recipe "kong::_from_package"
#    chef.add_recipe "kong::_configuration"

    chef.json = {
      java: {
        jdk_version: 8
      },
      #      cassandra: {
      #        install_method: "datastax",
      #        config: {
      #          cluster_name: "vagrant"
      #        }
      #      },
      kong: {
        version: "0.10.3",
        package_checksum: "eb46522783bcd1799a3a6647abb300b466b4f2570d0ebd43bf2b11b401d7e2d3",
        manage_cassandra: false

      },
      #      postgresql: {
      #        password: {
      #          postgres: "b3873e3ee1f184466e179d5e4e2b3313"  #the password is test123
      #          #generated with: echo -n 'test123''postgres' | openssl md5 | sed -e 's/.* /md5/'
      #        }
      #    }
      # kong: {
      #   version: "0.10.3",
      #   checksum: "983cddb9eff48c2488d07a90104d56c2274925b99dab81001025769410e70862"
      # }
#      'cassandra-platform': {
#        hosts: ['127.0.0.1'],
#        url: "http://mirrors.sonic.net/apache/cassandra/3.0.14/apache-cassandra-3.0.14-bin.tar.gz",
#        checksum: "0156c1bfc25021b98e9f6ca79e324b393a767fd947ff5825ea99e443b929c1a9"
#      }
    }
  end
end

Vagrant.configure("2") do |config|                      #Specify the version of the object “config”;​

    os = "bento/rockylinux-10"
    host_net = "192.168.200"
    config.vm.synced_folder '.', '/vagrant', disabled: true
    config.vbguest.auto_update=false
	
	#Configurare FiiPractic-App
	
	config.vm.define :app do |app_config|               #Define the VM object;​
        app_config.vm.provider "virtualbox" do |vb|     #Specify which provider should be used;​
            vb.memory = "2048"
            vb.cpus = 2                                 #Specify the properties of the VM;​
            vb.name = "Proiect-App"
        end

        app_config.vm.host_name = 'app.proiect.fiipractic.lan'
        app_config.vm.box = "#{os}"
        app_config.vm.network "private_network", ip: "#{host_net}.10"
                    
    end
	
	#Configurare FiiPractic-GitLab
	
	config.vm.define :gitlab do |gitlab_config|
        gitlab_config.vm.provider "virtualbox" do |vb|     #Specify which provider should be used;​
            vb.memory = "4096"
            vb.cpus = 4                                 #Specify the properties of the VM;​
            vb.name = "Proiect-GitLab"
        end

        gitlab_config.vm.host_name = 'gitlab.proiect.fiipractic.lan'
        gitlab_config.vm.box = "#{os}"
        gitlab_config.vm.network "private_network", ip: "#{host_net}.20"

        config.vm.provision "ansible" do |ansible|
            ansible.playbook = "netdata.yaml"
        end
	
    end

    config.vm.provision "ansible" do |ansible|
            ansible.playbook = "common.yml"
    end

end



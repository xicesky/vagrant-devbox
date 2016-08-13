# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    #config.vm.box = "chef/debian-7.6"
    config.vm.box = "debian/contrib-jessie64"
    #config.vm.box.version = ">= 0"

    # If true, then any SSH connections made will enable agent forwarding.
    # Default value: false
    config.ssh.forward_agent = true

    # Do NOT automatically replace the insecure key
    # (That feature does not seem to work right...)
    config.ssh.insert_key = false
  
    ####################################################################################################
    # Vagrant + Docker does not work properly on windows

    #config.vm.provider "docker" do |docker|
    #  docker.image = "debian/jessie"
    #end
    #config.vm.provision "docker"

    ####################################################################################################
    # Virtual machine (and provider-specific) configuration

    config.vm.provider "virtualbox" do |vb|
        vb.memory = 1024
        vb.cpus = 2
        #vb.gui = true
        #vb.customize ["modifyvm", :id, "--memory", "1024"]
    end

    config.vm.hostname = "devbox"

    ####################################################################################################
    # Ports

    # Web port
    #config.vm.network :forwarded_port, host: 80, guest: 80

    # PostgreSQL port
    #config.vm.network :forwarded_port, host: 5432, guest: 5432

    # JBoss web port
    #config.vm.network :forwarded_port, host: 8080, guest: 8080

    # JBoss debugging port
    #config.vm.network :forwarded_port, host: 8787, guest: 8787

    # JBoss management port
    #config.vm.network :forwarded_port, host: 9990, guest: 9990

    ####################################################################################################
    # Caching behaviour (vagrant cachier)

    if Vagrant.has_plugin?('vagrant-cachier')
        config.cache.auto_detect = true
        config.cache.scope = :box
        config.cache.enable :apt

        # https://github.com/fgrehm/vagrant-cachier/issues/57
        config.cache.enable :generic, {
            "maven" => { cache_dir: "/home/vagrant/.m2/repository" },
        }
    end

    ####################################################################################################
    # Provisioning configuration

    # Enable provisioning with Puppet stand alone.  Puppet manifests
    # are contained in a directory path relative to this Vagrantfile.
    # You will need to create the manifests directory and a manifest in
    # the file default.pp in the manifests_path directory.
    #
    # config.vm.provision "puppet" do |puppet|
    #   puppet.manifests_path = "manifests"
    #   puppet.manifest_file  = "default.pp"
    # end

    ####################################################################################################
    # Shell provisioning

    # Do the real provisioning
    config.vm.provision "shell", path: "support/vagrant/bootstrap.sh"

    # Copy user settings
    #config.vm.provision "file", source: "~/.gitconfig", destination: ".gitconfig-host"

    # Check if ~/.gitconfig exists locally
    # If so, copy basic Git Config settings to Vagrant VM
    if File.exists?(File.join(Dir.home, ".gitconfig"))
        git_name = `git config user.name`   # find locally set git name
        git_email = `git config user.email` # find locally set git email
        # set git name for 'vagrant' user on VM
        config.vm.provision :shell, :inline => "echo 'Saving local git username to VM...' && sudo -i -u vagrant git config --global user.name '#{git_name.chomp}'"
        # set git email for 'vagrant' user on VM
        config.vm.provision :shell, :inline => "echo 'Saving local git email to VM...' && sudo -i -u vagrant git config --global user.email '#{git_email.chomp}'"
    end
    config.vm.provision :shell, :inline => "echo 'Setting git aliases...' && sudo -i -u vagrant git config --global alias.st status"
    config.vm.provision :shell, :inline => "echo 'Setting git config...' && sudo -i -u vagrant git config --global color.ui auto"

    # After provisioning and each time the machine boots, run this script
    # to ensure services are started after the /vagrant directory is mounted

    config.vm.provision "shell", path: "support/vagrant/init.sh", run: "always"

    if not Vagrant.has_plugin?('vagrant-cachier')
        config.vm.provision "shell", path: "support/vagrant/note-cachier.sh", run: "always"
    end
    #config.vm.provision "shell", path: "support/vagrant/note-oldbox.sh", run: "always"

end

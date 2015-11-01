# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/vivid64"

  config.vm.provider "virtualbox" do |vm|
    vm.customize ["modifyvm", :id, "--memory", "1024"]
  end
end

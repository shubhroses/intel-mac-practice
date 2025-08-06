Vagrant.configure("2") do |config|
  config.vm.box = "hashicorp/bionic64"

  config.vm.network "forwarded_port", guest: 5000, host: 5004
  config.vm.network "forwarded_port", guest: 22, host: 2223
end


curl https://apt.releases.hashicorp.com/gpg | gpg --dearmor > hashicorp.gpg

sudo install -o root -g root -m 644 hashicorp.gpg /etc/apt/trusted.gpg.d/

sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com focal main"

sudo apt update
sudo apt install terraform
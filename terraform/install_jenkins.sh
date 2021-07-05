

#!/bin/bash
sudo yum -y update

echo "Install Java JDK 8"
yum remove -y java
yum install -y java-1.8.0-openjdk-devel 

echo "Install Maven"
yum install -y maven 

echo "Install git"
yum install -y git

echo "Install Docker engine"
yum update && amazon-linux-extras install docker -y
service docker start
usermod -aG docker ec2-user
chkconfig docker on


echo "Install Python3"
yum install python3 -y
pip install pip --upgrade
yum -y install wget

echo "Add ons"
curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
curl -L https://raw.githubusercontent.com/docker/compose/1.24.1/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x kubectl
mv kubectl /usr/local/bin
wget https://releases.hashicorp.com/terraform/0.15.0/terraform_0.15.0_linux_amd64.zip
yum -y install unzip
unzip terraform_0.15.0_linux_amd64.zip
mv terraform /usr/local/bin/
terraform -install-autocomplete
curl -sSL https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
yum install jq -y

echo "Install Jenkins"
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum upgrade
yum install -y jenkins
systemctl daemon-reload
systemctl start jenkins
usermod -a -G docker jenkins
chkconfig jenkins on
service docker start
service jenkins start

source ~/.bashrc
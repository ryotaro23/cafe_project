sudo yum update -y

# Gitのインストール
sudo yum install git -y

# Dockerのインストール
sudo yum install -y docker

# Dockerの起動
sudo service docker start
sudo systemctl enable docker.service
sudo service docker status

# dockerコマンドを使用可能にする
sudo usermod -a -G docker ec2-user

sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
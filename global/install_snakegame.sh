#!/bin/bash
set -e
exec > /var/log/user-data.log 2>&1
yum update -y
yum install -y git python3
sudo -u ec2-user bash <<'EOF'
cd /home/ec2-user
if [ ! -d SnakeGame ]; then
  git clone https://github.com/IvanVlhv/SnakeGame.git
fi
cd SnakeGame
pip3 install --user -r requirements.txt
nohup python3 app.py &
EOF

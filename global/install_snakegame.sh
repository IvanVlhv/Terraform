#!/bin/bash
set -e
yum update -y
yum install -y git python3
cd "$HOME"
if [ ! -d SnakeGame ]; then
  git clone https://github.com/IvanVlhv/SnakeGame.git
fi
cd SnakeGame
pip3 install --user -r requirements.txt
nohup python3 app.py &
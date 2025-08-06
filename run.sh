#!/bin/bash
set -euo pipefail

PROJECT_DIR="/home/vagrant/intel-mac-practice"
PROJECT_REPO="https://github.com/shubhroses/intel-mac-practice.git"

echo ""
echo "1. Ensure vagrant is up and running"
vagrant up

echo ""
echo "2. Check if project directory exists and clone/pull"
vagrant ssh -c "
  if [ -d '${PROJECT_DIR}' ]; then
    echo 'Running git pull'
    cd ${PROJECT_DIR} && git pull
  else
    echo 'running git clone'
    git clone ${PROJECT_REPO} ${PROJECT_DIR}
  fi  
"

echo ""
echo "3. Build docker image"
vagrant ssh -c "cd ${PROJECT_DIR} && docker build -t flask-demo ."

echo ""
echo "4. Run and test"
vagrant ssh -c "cd ${PROJECT_DIR} && docker run flask-demo"
vagrant ssh -c "cd ${PROJECT_DIR} && curl://localhost:5000"

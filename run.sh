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
echo "4. Import docker image to k3s"
vagrant ssh -c "cd ${PROJECT_DIR} && docker save flask-demo | sudo k3s ctr images import -"

echo ""
echo "5. Restart deployment and wait till it finishes"
vagrant ssh -c "cd ${PROJECT_DIR} && sudo k3s kubectl apply -f k8s-deploy.yaml"

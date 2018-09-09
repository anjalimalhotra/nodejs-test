#!/bin/bash

# configure node.js repo
curl --silent --location https://rpm.nodesource.com/setup_8.x | bash -

# install node.js
yum install nodejs -y

# create systemd service
cat > /etc/systemd/system/nodejs.service <<'EOF'
[Unit]
Description=Node.js App
After=network.target
[Service]
User=nobody
WorkingDirectory=/var/www/nodejs
ExecStart=/usr/bin/npm run start:dev
Restart=always
RestartSec=500ms
StartLimitInterval=0
[Install]
WantedBy=multi-user.target
EOF



# reload systemd services
systemctl daemon-reload
systemctl enable nodejs.service

# remove old directory
rm -rf /var/www/nodejs

# create directory node.js app
mkdir -p /var/www/nodejs 

















sudo service anup-routing stop

# create anup-routing service
cat > /etc/init/anup-routing.conf <<'EOF'

description "anup Routing Server"

  start on runlevel [2345]
  stop on runlevel [!2345]
  respawn
  respawn limit 10 5

  # run as non privileged user 
  # add user with this command:
  ## adduser --system --ingroup www-data --home /opt/apache-tomcat apache-tomcat
  # Ubuntu 12.04: (use 'exec sudo -u apache-tomcat' when using 10.04)
  setuid ubuntu
  setgid ubuntu

  # adapt paths:
  env DATABASE_NAME=anup_routing
  env PG_PASSWORD=AnupJulyFive2018
  env PG_USER=anup
  env DATABASE_SERVER=anup.snsnsjkskjj.us-west-2.rds.amazonaws.com
  env PORT=8080
  env LOG_LEVEL=debug
  env rabbitmq_host=diligent-0----------
  env rabbitmq_username=--------
  env rabbitmq_password=------------
  env google_api_key=------------------
  env environment=prod
  env jsprit_run_size=200
  env jsprit_thread_count=2
  exec java  -Dfile.encoding=UTF-8 -XX:MaxPermSize=256M -Xms512M -Xmx2018M -jar /home/ubuntu/deploy/anup_routing_engine-0.0.1-SNAPSHOT.war --spring.rabbitmq.virtual-host=rejaybnk >> /home/ubuntu/logs/routing.log 2>&1

  # cleanup temp directory after stop
  post-stop script
    #rm -rf $CATALINA_HOME/temp/*
  end script
EOF

# remove old directory
rm -rf /home/ubuntu/deploy

# create directory deploy
mkdir -p /home/ubuntu/deploy 



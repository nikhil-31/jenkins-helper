Installing jenkins on localhost

# Just the ports
sudo docker run -p 8080:8080 -p 50000:50000 --restart=on-failure -d -v jenkins_home:/var/jenkins jenkins/jenkins:lts

# This will create a jenkins server and add a volume to store the jenkins data
docker run -p 8080:8080 -p 50000:50000 --restart=on-failure -v jenkins_home:/var/jenkins_home jenkins/jenkins:lts-jdk11


# This will start the nginx server
docker run --rm --name nginx -p 80:80 -p 443:443 \
    -v ~/conf/nginx.conf:/etc/nginx/conf.d/nginx.conf:ro \
    -v /var/www/html:/var/www/html \
    nginx:1.19.0

docker run --rm --name nginx -p 80:80 -p 443:443 \
    -v ~/conf/nginx.conf:/etc/nginx/conf.d/nginx.conf:ro \
    -v /var/www/html:/var/www/html \
    nginx:1.19.0


# Running certbot and lets encrypt to get certificate

# Staging
docker run -it --rm -p 80:80 --name certbot \
         -v "/etc/letsencrypt:/etc/letsencrypt" \
         -v "/var/lib/letsencrypt:/var/lib/letsencrypt" \
         certbot/certbot certonly --standalone --staging -d jenkins.splashco.in

# Production
docker run -it --rm -p 80:80 --name certbot \
         -v "/etc/letsencrypt:/etc/letsencrypt" \
         -v "/var/lib/letsencrypt:/var/lib/letsencrypt" \
         certbot/certbot certonly --standalone -d jenkins.splashco.in


docker run --rm --name nginx -p 80:80 -p 443:443 \
    -v ~/conf/nginx.conf:/etc/nginx/conf.d/nginx.conf:ro \
    -v /etc/letsencrypt:/etc/letsencrypt \
    -v /var/lib/letsencrypt:/var/lib/letsencrypt \
    -v /var/www/html:/var/www/html \
    --network jenkins-net \
    nginx:1.19.0


# From riot games blog (https://technology.riotgames.com/news/docker-jenkins-data-persists)

# Building the docker image
docker build -t myjenkins .

# Creating the docker network
docker network create --driver bridge jenkins-net

# Create docker volume 
docker volume create jenkins-log
docker volume create jenkins-data

# Using the new jenkins data volume and log volume 
docker run -p 8080:8080 -p 50000:50000 --name=jenkins-master \
    --mount source=jenkins-log,target=/var/log/jenkins \
    --mount source=jenkins-data,target=/var/jenkins_home \
    --network jenkins-net \
    -d myjenkins


# Running the docker in the VM and then socketing it into the container
docker run -p 8080:8080 -p 50000:50000 --name=jenkins-master \
    --mount source=jenkins-log,target=/var/log/jenkins \
    --mount source=jenkins-data,target=/var/jenkins_home \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v $(which docker):/usr/bin/docker \
    --network jenkins-net \
    -d myjenkins

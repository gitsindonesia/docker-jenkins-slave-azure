FROM jenkins/ssh-slave
MAINTAINER Farhan Naufal Ghani <farhan.naufalghani@gmail.com>
LABEL Description="This is a jenkins slave project for azure container" Vendor="GITS Indonesia" Version="1.0"

RUN apt-get update && apt-get install -y apt-transport-https

# Install Azure CLI
RUN apt-get install lsb-release -y
RUN AZ_REPO=$(lsb_release -cs)
RUN echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ stretch main" | \
    tee /etc/apt/sources.list.d/azure-cli.list
RUN curl -L https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN apt-get update 
RUN apt-get install azure-cli


# Install Kuber
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
RUN touch /etc/apt/sources.list.d/kubernetes.list 
RUN echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list
RUN apt-get update
RUN apt-get install kubectl -y

# Install docker
RUN apt-get install \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common -y
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   stretch \
   stable"
RUN apt-get update -y && apt-get install docker-ce -y
RUN usermod -a -G docker jenkins

# Install HELM
RUN curl https://storage.googleapis.com/kubernetes-helm/helm-v2.10.0-rc.1-linux-amd64.tar.gz --output /opt/helm-v2.10.tar.gz
RUN tar -zxvf /opt/helm-v2.10.tar.gz
COPY linux-amd64/helm /usr/local/bin/helm

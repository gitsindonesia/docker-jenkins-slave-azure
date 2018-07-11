FROM jenkins/ssh-slave
MAINTAINER Farhan Naufal Ghani <farhan.naufalghani@gmail.com>
LABEL Description="This is a jenkins slave project for azure container" Vendor="GITS Indonesia" Version="1.0"


RUN apt-get update && apt-get install -y apt-transport-https

# Install Azure CLI
RUN curl -L https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN apt-get update && apt-get install azure-cli


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

# Install Kedge
RUN curl -L https://github.com/kedgeproject/kedge/releases/download/v0.12.0/kedge-linux-amd64 -o kedge && \
    chmod +x kedge && \
    mv ./kedge /usr/local/bin/kedge
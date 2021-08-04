FROM centos:centos8 

# install workable tools
COPY src/ttyd /usr/bin/ttyd
COPY src/tini /sbin/tini
COPY src/kubectl /usr/bin/kubectl
RUN chmod +x /sbin/tini && \
    chmod +x /usr/bin/kubectl && \
    chmod +x /usr/bin/ttyd && \
    yum install -y git
EXPOSE 7681
WORKDIR /root

# install istioctl client
COPY src/istio-1.10.0.tar.gz ./
RUN tar -zxf istio-1.10.0.tar.gz && \
    chmod +x istio-1.10.0/bin/istioctl && \
    rm -fr istio-1.10.0.tar.gz 
ENV PATH "${PATH}:/root/istio-1.10.0/bin"

# Install docker client    
RUN yum install -y wget && \
    wget -q "https://download.docker.com/linux/static/stable/x86_64/docker-19.03.6.tgz" && \
    tar -zxf docker-19.03.6.tgz -C /usr/local/bin --strip=1 docker/docker && \
    chmod +x /usr/local/bin/docker

# setup start command
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["ttyd", "bash"]

FROM centos:centos7 


COPY istio-1.10.0.tar.gz ./

RUN tar -zxf istio-1.10.0.tar.gz && \
    chmod +x istio-1.10.0/bin/istioctl && \
    rm -fr istio-1.10.0.tar.gz && \
    mv istio-1.10.0 /root/

COPY ttyd /usr/bin/ttyd
COPY tini /sbin/tini
COPY kubectl /usr/bin/kubectl
RUN chmod +x /sbin/tini && chmod +x /usr/bin/kubectl && chmod +x /usr/bin/ttyd
EXPOSE 7681
WORKDIR /root

ENV PATH "${PATH}:/root/istio-1.10.0/bin"

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["ttyd", "bash"]

FROM codeql:latest

RUN curl -LO https://go.dev/dl/go1.20.3.linux-amd64.tar.gz && \
    tar zxvf go1.20.3.linux-amd64.tar.gz && \
    rm go1.20.3.linux-amd64.tar.gz

ENV PATH "/go/bin:$PATH"

USER worker
WORKDIR /home/worker

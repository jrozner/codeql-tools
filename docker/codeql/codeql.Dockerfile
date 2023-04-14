FROM ubuntu:latest

RUN apt update && \
    apt install -y curl git && \
    rm -rf /var/lib/apt/lists/* && \
    curl -LO https://github.com/github/codeql-action/releases/latest/download/codeql-bundle-linux64.tar.gz && \
    tar zxvf codeql-bundle-linux64.tar.gz && \
    rm codeql-bundle-linux64.tar.gz && \
    useradd -m -U worker

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENV PATH="/codeql:$PATH"

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["codeql"]

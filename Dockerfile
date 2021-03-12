FROM docker:19.03-dind

ENV VERSION=v0.17.0

RUN apk add --update --no-cache \
        curl \
        bash \
        ca-certificates \
        groff \
        less \
        build-base \
        python3 \
        python3-dev \
        libffi-dev \
        openssl-dev \
        py-pip \
    && rm -rf /var/cache/apk/* \
    && pip install pip --upgrade \
    && pip install awscli && \
    curl -LO https://github.com/buildpacks/pack/releases/download/${VERSION}/pack-${VERSION}-linux.tgz && \
    tar xfz pack-${VERSION}-linux.tgz && \
    mv pack /usr/bin/

RUN mkdir /work
COPY entrypoint.sh /work/entrypoint.sh
RUN chmod +x /work/entrypoint.sh

ENTRYPOINT [ "/work/entrypoint.sh" ]

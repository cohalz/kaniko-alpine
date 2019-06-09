FROM gcr.io/kaniko-project/executor:latest

FROM alpine:latest
COPY --from=0 /kaniko/executor /kaniko/executor
COPY --from=0 /kaniko/docker-credential-gcr /kaniko/docker-credential-gcr
COPY --from=0 /kaniko/docker-credential-ecr-login /kaniko/docker-credential-ecr-login
COPY --from=0 /kaniko/ssl/certs/ /kaniko/ssl/certs/
COPY --from=0 /root/.docker/config.json /kaniko/.docker/config.json
ENV HOME /root
ENV USER /root
ENV PATH /bin:/usr/bin:usr/local/bin:/kaniko
ENV SSL_CERT_DIR=/kaniko/ssl/certs
ENV DOCKER_CONFIG /kaniko/.docker/
ENV DOCKER_CREDENTIAL_GCR_CONFIG /kaniko/.config/gcloud/docker_credential_gcr_config.json
WORKDIR /workspace
RUN ["docker-credential-gcr", "config", "--token-source=env"]
ENTRYPOINT ["/kaniko/executor"]

FROM node:18-slim

LABEL "com.github.actions.name"="vue-s3-deployer"
LABEL "com.github.actions.description"="Github action for deploy Vue app to Amazon s3 bucket. "
LABEL "com.github.actions.icon"="archive"
LABEL "com.github.actions.color"="orange"

LABEL "original_maintainer"="Lewandy Diloné Bonifacio <lewandydilone1@live.com>"
LABEL "original_repository"="https://github.com/lewandy/vue-s3-deployer"
LABEL "maintainer"="Ethan Doh"
LABEL "repository"="https://github.com/neoswallow/vue-s3-deployer"
LABEL version="1.0.1"

#Install utilities
RUN apt-get update && \ 
    apt-get install -y curl && \
    apt-get install unzip

# Install aws cli v2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip > /dev/null 2>&1
RUN ./aws/install

ADD entrypoint.sh /entrypoint.sh

#Make entrypoint file executable
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]

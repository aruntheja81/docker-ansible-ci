FROM docker:stable

ARG ANSIBLE_VERSION=2.8.*
ARG MOLECULE_VERSION=2.22

ENV ANSIBLE_VERSION=${ANSIBLE_VERSION}
ENV MOLECULE_VERSION=${MOLECULE_VERSION}

LABEL maintainer="team@lean-delivery.com"

RUN apk add --no-cache git python3-dev gcc rsync musl-dev libffi-dev openssl-dev make openssh-client && rm -rf /var/cache/apk/*
RUN wget --quiet https://releases.hashicorp.com/terraform/0.11.11/terraform_0.11.11_linux_amd64.zip \
    && unzip terraform_0.11.11_linux_amd64.zip && mv terraform /usr/bin/ && rm terraform_0.11.11_linux_amd64.zip
RUN pip3 install --no-cache --upgrade pip setuptools==41.0.0 wheel pywinrm[credssp] boto boto3 \
    ansible[azure]==$ANSIBLE_VERSION docker pyOpenSSL PyYAML pytest molecule==$MOLECULE_VERSION \
    git+https://github.com/ansible/ansible-lint.git
#RUN pip3 install git+https://github.com/ansible/molecule@$MOLECULE_VERSION
#RUN pip3 install \
#   --index-url https://test.pypi.org/simple \
#   --extra-index-url https://pypi.org/simple \
#   molecule==2.21.dev46
# RUN pip3 install --upgrade ansible==$ANSIBLE_VERSION docker pyOpenSSL PyYAML pytest
# RUN pip3 install pywinrm[credssp] boto boto3
#RUN pip3 install ansible[azure]
# RUN pip3 install molecule==$MOLECULE_VERSION
# RUN pip3 install git+https://github.com/ansible/ansible-lint.git && \
#    ansible --version && \
#    ansible-lint --version && \
#    molecule --version

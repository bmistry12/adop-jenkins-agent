FROM jenkins/jnlp-slave

LABEL maintainer="Bhavina Mistry"

ENV JAVA_VERSION 8u171
ENV JAVA_BUILD b11
ENV ANSIBLE_VERSION 2.4.3.0
ENV MAVEN_VERSION 3.3.9
ENV LANG C.UTF-8
ENV JENKINS_URL ""
ENV JENKINS_AGENT_WORKDIR /workspace
# ENV JENKINS_SECRET
# ENV JENKINS_AGENT_NAME

USER root

RUN apt-get update
RUN apt-get install -y apt-transport-https default-jre
RUN apt-get update && \
    apt-get install -y python-dev python-pip wget curl git vim && \
    apt-get install -y awscli && \
    aws --version && \
    mkdir /.ansible && \
    mkdir -p /home/jenkins/.ssh && \
    mkdir -p /root/.ssh && \
    chown -R jenkins:jenkins /home/jenkins/.ssh && \
    chmod a+rw /.ansible && \
    pip install ansible==${ANSIBLE_VERSION} && \
    # pip install azure ansible[azure] msrestazure packaging && \
    mkdir -p /opt/ansible/inventory && \
    wget -O /opt/ansible/inventory/ec2.py https://raw.githubusercontent.com/ansible/ansible/devel/contrib/inventory/ec2.py && \
    chmod +x /opt/ansible/inventory/ec2.py && \
    mkdir /workspace && \
    chown -R jenkins:jenkins /workspace && \
    pip uninstall --yes pyopenssl && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* /root/.cache

# Files required for Ansible Configuration
COPY files/ansible.cfg /etc/ansible/ansible.cfg
COPY files/config     /home/ubuntu/.ssh/config
COPY files/config     /root/.ssh/config

COPY agent.jar /usr/local/bin/agent.jar

CMD java -jar /usr/local/bin/agent.jar -url ${JENKINS_URL} -workDir ${JENKINS_AGENT_WORKDIR} ${ADOPM_SECRET} ${JENKINS_AGENT_NAME}

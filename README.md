# Jenkins Agent

This Jenkins Agent uses the `jenkins/jnlp` agent Docker image: https://hub.docker.com/r/jenkinsci/jnlp-slave/

### Create Node On Jenkins Master

1. Navigate to _Manage Jenkins_/_Manage_Nodes_
2. Click on _New Node_ on the left-hand side.
3. Choose an appropiate Node Name and choose _Permament Agent_.
4. Fill out the following specific parameters and click _Save_.
    - **# of executors**: The maximum number of parallel jobs that you can run on this node. (E.g. 5)
    - **Remote root directory**: /
    - **Labels**: The jobs referencing this label will run on this node.
    - **Custom WorkDir path**: /workspace	
5. Take note and keep private the argument after the ```jnlpUrl``` and ```secret```. They are your ```JENKINS_URL``` and ```ADOP_SECRET``` respectively.
6. Download `agent.jar` for your node
7. Disable JNLP 1-3: By default if JNLP4 connections fail, the agent will attempt to make connections using earlier JNLP protocols (1,2 or 3). These don't follow the same security standards as JNLP4. 
    - Navigate to _Manage Jenkins_/_Configure Global Security_
    - Expand the ```Agent Protocols``` and disable all protocols except JNLP4.

### Build Docker image and run the new agent
1) Create a new VM to run the agent in and install Docker.
2) Clone the repository that contains Agent.jar (from jenkins) and /files and Dockerfile
3) Build a docker image  `docker build -t jenkins-agent .`
4) Run the image on the VM
    `nohup docker run --name=jenkins-agent --restart always jenkins-agent <ADOPM_SECRET> <Node_Name> &`
5) The VM is now linked to your Jenkins Node 

### What's installed on the agent?
- Java 8.171
- Ansible 2.4.3.0
- Maven 3.5.4
- Python 2.7.13
- AWS-cli 1.11.13
- Git 2.11.0
- wget
- curl
- vim

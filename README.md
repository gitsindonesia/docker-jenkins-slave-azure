# Jenkins SSH slave Docker image + Azure

[`gitsid/jenkins-slave-azure`](https://hub.docker.com/r/gitsid/jenkins-slave-azure/)

A [Jenkins](https://jenkins-ci.org) slave using SSH to establish connection + Azure CLI

## Running

To run a Docker container

```bash
docker run gitsid/jenkins-slave-azure "<public key>"
```

You'll then be able to connect this slave using ssh-slaves-plugin as "jenkins" with the matching private key.

### How to use this image with Docker Plugin

To use this image with [Docker Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Docker+Plugin), you need to
pass the public SSH key using environment variable `JENKINS_SLAVE_SSH_PUBKEY` and not as a startup argument.

In _Environment_ field of the Docker Template (advanced section), just add:

    JENKINS_SLAVE_SSH_PUBKEY=<YOUR PUBLIC SSH KEY HERE>

Don't put quotes around the public key. You should be all set.

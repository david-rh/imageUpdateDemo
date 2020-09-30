# imageUpdateDemo

This project is intended to provide a simple demonstration of why and how to use ImageStreams with Deployment resources in openshift. By using ImageStreams in openshift, you have the ability to manage and automate the deployment of new images based on a given tag.

This project includes a simple python (django) website which responds with a simple hello message. Using GitHub and Quay.io, you can setup an automated build of the image.

Steps to run the demo.


On GitHub

* Fork this project.
* Create a branch with the desired version label. This will correspond to the image tag.

On Quay.io

* Create a new repository
* Select "Link to a GitHub Repository Push" - follow instructions to setup github link

On GitHub

* Edit the file imageStreamDeployment.yaml replace image reference in Deployment with the image reference from Quay.io
* Edit the file deploymentOnly.yaml replace image reference in Deployment with the image reference from Quay.io and desired version tag.


On OpenShift

* Create a new project
* Apply either the imageStreamDeployment.yaml or the deploymentOnly.yaml
* Wait for service to start, and then view the page using the route url.

On Github

* Edit the file demosite/hello/views.py, change the response text line.
* Save and commit changes to the branch.

Wait for image to get rebuilt and imagestream (if created) to get updated.

* View page again.


If the ImageStream was not created the application will continue to use the old image.

However, by using an ImageStream, OpenShift will detect and pull in the new image for a given tag. The DeploymentConfig resource supports triggers based on image updates. However, the Kubernetes Deployment object does not support the use of triggers. So, in order to ensure that the new image is deployed, we need to include the following annotation in the Deployment definition

```
- apiVersion: apps/v1
  kind: Deployment
  metadata:
    name: demosite
    labels:
      app: demosite
    annotations:
      alpha.image.policy.openshift.io/resolve-names: '*'
      image.openshift.io/triggers: '[{"from":{"kind":"ImageStreamTag","name":"demosite:0.2"},"fieldPath":"spec.template.spec.containers[?(@.name==\"demosite\")].image","pause":"false"}]'


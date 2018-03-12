# Simple Jenkins integration with Minikube/Minishift using Helm

Start minishift 

    minishift addons enable admin-user
    minishift start --vm-driver=virtualbox --openshift-version=v3.7.0 --cpus=3 --memory=8192

Helm installation details can be found here https://docs.helm.sh/using_helm/#installing-the-helm-client

From Homebrew(macOS)

    brew install kubernetes-helm
    
Install Tiller (Server Side) https://blog.openshift.com/deploy-helm-charts-minishifts-openshift-local-development/

For latest Helm version

    $ git clone https://github.com/jorgemoralespou/minishift-addons
    $ cd minishift-addons
    $ vi helm/helm.addon
    update docker image lachlanevenson/k8s-helm:v2.5.0 to lachlanevenson/k8s-helm:latest
    $ minishift addons install helm
    $ minishift addons apply helm
    $ oc get pods -n kube-system
      NAME                            READY     STATUS    RESTARTS   AGE
      tiller-deploy-272758109-s7z4x   1/1       Running   1          4h

Tiller (Server side) pod is deployed in kube-system project,once tiller pod is in running status

    $ export TILLER_HOST="$(minishift ip):$(oc get svc/tiller -o jsonpath='{.spec.ports[0].nodePort}' -n kube-system --as=system:admin)"
    $ echo $TILLER_HOST
      192.168.99.100:30609

Deploying Jenkins pod using Helm 
  1. In values.yml adminuser and password are set
  2. ImageTag,ServiceType,InstallPlugins are modified
    
    $ git clone https://github.com/Vikaspogu/simple-jenkins-helm.git
    $ cd simple-cicd
    $ oc new-project jenkins
    $ helm install --name jenkins -f demo/jenkins/values.yml stable/jenkins --host $TILLER_HOST --kube-context default/192-168-99-100:8443/system:admin --namespace jenkins
    $ oc expose svc jenkins --hostname jenkins.$(minishift ip).nip.io
    
Navigate to Jenkins url jenkins.$(minishift ip).nip.io
1. login with admin user and password
2. Update plugins
3. Click on Blueocean and create a pipeline

Any issues with volumes and security context, please update following
https://docs.openshift.org/latest/admin_guide/manage_scc.html#modify-cluster-default-behavior
https://docs.openshift.org/latest/admin_guide/manage_scc.html#use-the-hostpath-volume-plugin
 


First install [Kubectl](https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html) in terminal.

```bash
kubectl version --client
```

## Configure kubeconfig for kubectl

```bash
aws eks --region <region-code> update-kubeconfig --name <cluster_name>
aws eks --region us-east-1 update-kubeconfig --name SAP-dev-eksdemo1
```

## List Worker Nodes

```bash
kubectl get nodes
kubectl get nodes -o wide
```

## Verify Services
```bash
kubectl get svc
```

##### Connect to EKS Worker Nodes using Bastion Host

## Connect to Bastion EC2 Instance

```bash
ec2-user@<Bastion-EC2-Instance-Public-IP>
cd /tmp
ssh -i private-key/eks-terraform-key.pem 
```

## Connect to Kubernetes Worker Nodes - Public Node Group

```bash
ec2-user@<Public-NodeGroup-EC2Instance-PublicIP> 
[or]
ec2-user@<Public-NodeGroup-EC2Instance-PrivateIP>

ssh -i private-key/eks-terraform-key.pem 

```

## Connect to Kubernetes Worker Nodes - Private Node Group from Bastion Host

```bash
ssh -i eks-terraform-key.pem ec2-user@<Private-NodeGroup-EC2Instance-PrivateIP>
```
##### REPEAT BELOW STEPS ON BOTH PUBLIC AND PRIVATE NODE GROUPS ####
# Verify if kubelet and kube-proxy running
ps -ef | grep kube

## Verify kubelet-config.json
cat /etc/kubernetes/kubelet/kubelet-config.json

## Verify kubelet kubeconfig
cat /var/lib/kubelet/kubeconfig

```bash
chmod 400 /Users/mohammad/Desktop/terraform/08-AWS-EKS-Cluster-Basics/01-ekscluster-terraform-manifests/private-key
```
```bash 
ssh -i /Users/mohammad/Desktop/terraform/08-AWS-EKS-Cluster-Basics/01-ekscluster-terraform-manifests/private-key/terraform_newKey.pem ec2-user@52.206.112.132
```
```Bash
ssh -i terraform_newKey.pem ec2-user@54.87.140.55 | bastionHost to pod instance
```

## Verify Namespaces
```Bash
kubectl get namespaces
kubectl get ns 
```
Observation: 4 namespaces will be listed by default
1. kube-node-lease
2. kube-public
3. default
4. kube-system

## Verify Resources in kube-node-lease namespace
```Bash
kubectl get all -n kube-node-lease
```
## Verify Resources in kube-public namespace
```Bash
kubectl get all -n kube-public
```
## Verify Resources in default namespace
kubectl get all -n default Observation: 
1. Kubernetes Service: Cluster IP Service for Kubernetes Endpoint

## Verify Resources in kube-system namespace
kubectl get all -n kube-system Observation: 
1. Kubernetes Deployment: coredns
2. Kubernetes DaemonSet: aws-node, kube-proxy
3. Kubernetes Service: kube-dns
4. Kubernetes Pods: coredns, aws-node, kube-proxy


## Verify pods in kube-system namespace
## Verify System pods in kube-system namespace

kubectl get pods 

## Nothing in default namespace
```Bash
kubectl get pods -n kube-system
kubectl get pods -n kube-system -o wide
```
## Verify Daemon Sets in kube-system namespace
kubectl get ds -n kube-system Observation: The below two daemonsets will be running
1. aws-node
2. kube-proxy

## Describe aws-node Daemon Set
kubectl describe ds aws-node -n kube-system Observation: 
1. Reference "Image" value it will be the ECR Registry URL 

## Describe kube-proxy Daemon Set
kubectl describe ds kube-proxy -n kube-system
1. Reference "Image" value it will be the ECR Registry URL 

## Describe coredns Deployment
```Bash
kubectl describe deploy coredns -n kube-system
```

#################################

## List Pods

```Bash
kubectl get pods
```

## Alias name for pods is po
```Bash
kubectl get po
kubectl get po -o wide
```

## Describe the Pod
```Bash
kubectl describe pod <Pod-Name>
kubectl describe pod my-first-pod 
```
## Delete Pod
```Bash
kubectl delete pod <Pod-Name>
kubectl delete pod my-first-pod
```
##########################################

## Create  a Pod
```Bash
kubectl run <desired-pod-name> --image <Container-Image> --generator=run-pod/v1
kubectl run my-first-pod --image stacksimplify/kubenginx:1.0.0 --generator=run-pod/v1
```

## Expose Pod as a Service
```Bash
kubectl expose pod <Pod-Name>  --type=NodePort --port=80 --name=<Service-Name>
kubectl expose pod my-first-pod  --type=NodePort --port=80 --name=my-first-service
```

## Get Service Info
```Bash
kubectl get service
kubectl get svc
```

## Get Public IP of Worker Nodes
```Bash
kubectl get nodes -o wide
```
### Access the Application using Public IP
http://<node1-public-ip>:<Node-Port>

### Important Note about: target-port
If target-port is not defined, by default and for convenience, the targetPort is set to the same value as the port field.

### Below command will fail when accessing the application, as service port (81) and container port (80) are different
```Bash
kubectl expose pod my-first-pod  --type=NodePort --port=81 --name=my-first-service2   
```  

### Expose Pod as a Service with Container Port (--taret-port)
```Bash
kubectl expose pod my-first-pod  --type=NodePort --port=81 --target-port=80 --name=my-first-service3
```
## Get Service Info
```Bash
kubectl get service
kubectl get svc
```
## Get Public IP of Worker Nodes
```Bash
kubectl get nodes -o wide
```
### Connect to a Container in POD and execute commands

## Connect to Nginx Container in a POD
```Bash
kubectl exec -it <pod-name> -- /bin/bash
kubectl exec -it my-first-pod -- /bin/bash
```

## Execute some commands in Nginx container
ls
cd /usr/share/nginx/html
cat index.html
exit

--> Running individual commands in a Container

kubectl exec -it <pod-name> env

## Sample Commands
```Bash
kubectl exec -it my-first-pod env
kubectl exec -it my-first-pod ls
kubectl exec -it my-first-pod cat /usr/share/nginx/html/index.html
```
--> Get YAML Output
## Get pod definition YAML output
```Bash
kubectl get pod my-first-pod -o yaml   
```
## Get service definition YAML output
```Bash
kubectl get service my-first-service -o yaml   
```
--> Clean-Up
## Get all Objects in default namespace
```Bash
kubectl get all
```
## Delete Services
```Bash
kubectl delete svc my-first-service
kubectl delete svc my-first-service2
kubectl delete svc my-first-service3
```
## Delete Pod
```Bash
kubectl delete pod my-first-pod
```
## Get all Objects in default namespace
```Bash
kubectl get all
```
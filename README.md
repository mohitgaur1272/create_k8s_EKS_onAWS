# create_EKS_onAWS

## create ec2 instance 

### then install aws cli 

```
sudo apt install unzip 
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws --version 
```

### run this command for configure

```
aws configure
```
### give access and secreet key for aws configure 

## install kubectl top version 

```
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.29.0/2024-01-04/bin/linux/amd64/kubectl
chmod +x ./kubectl
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH
echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc
kubectl version --client
```

## install eksctl

```
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
eksctl version
```

# now create cluster 

```
eksctl create cluster --name w3cluster --region us-east-1 --node group-name w3node --node type t2.medium --nodes 2 --node min 1 --node max 3 --managed
aws eks update-kubeconfig --region us-east-1 --name w3cluster
```

### replace with your cluster desired cluster name 
### replace with your regin name when you want to create eks 
### replace with your desired node group name 
### replace with your desired worker node type 
### replace with your desired node count 
### replace with your desired min node count 
### replace with your desired max node count


## delete cluster 

```
eksctl delete cluster --name w3cluster --region us-east-1
```


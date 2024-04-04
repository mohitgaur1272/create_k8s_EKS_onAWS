# create_EKS_onAWS

## create ec2 instance 

### then install aws cli 

```
sudo apt install unzip 
sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo unzip awscliv2.zip
sudo ./aws/install
aws --version 
```

## Create IAM role & attach to EKS Management Host
### Create New Role using IAM service ( Select Usecase - ec2 )

#### Add below permissions for the role
```
IAM - fullaccess
VPC - fullaccess
EC2 - fullaccess
CloudFomration - fullaccess
Administrator - acces
```
Enter Role Name (eksroleec2)

Attach created role to EKS Management Host (Select EC2 => Click on Security => Modify IAM Role => attach IAM role we have created)
### and you can use other method select your iam user and create access key and secret key 
### run this command for configure

```
aws configure
```
### give access and secreet key for aws configure 

## install kubectl top version 

```
sudo curl -LO https://s3.us-west-2.amazonaws.com/amazon-eks/1.29.0/2024-01-04/bin/linux/amd64/kubectl
sudo chmod +x ./kubectl
sudo mv kubectl /usr/local/bin/kubectl
echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
kubectl version --client
```

## install eksctl

```
sudo curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
eksctl version
```

# now create cluster 
## for Mumbai:

```
eksctl create cluster --name w3cluster --region ap-south-1 --nodegroup-name w3node --node-type t2.micro --nodes 2 --nodes-min 1 --nodes-max 3 --managed
```
## for N. Virgina:
```
eksctl create cluster --name w3cluster --region us-east-1 --nodegroup-name w3node --node-type t2.micro --nodes 2 --nodes-min 1 --nodes-max 3 --managed
```

### connect cluster with your server 
```
aws eks update-kubeconfig --region ap-south-1 --name w3cluster
```

### replace with your cluster desired cluster name 
### replace with your regin name when you want to create eks 
### replace with your desired node group name 
### replace with your desired worker node type 
### replace with your desired node count 
### replace with your desired min node count 
### replace with your desired max node count

## if you want to delete only nodegroup use this command 
```
eksctl delete nodegroup --cluster w3cluster --region ap-south-1 --name w3node
```

### scale down cluster node 
```
eksctl scale nodegroup --cluster w3cluster --name w3node --nodes 0
```


## delete cluster 

```
eksctl delete cluster --name w3cluster --region ap-south-1
```


# sb-infra


# Steps to launch K8s on AWS EKS

- Create IAM roles for eks master and workers following [AWS doc](https://docs.aws.amazon.com/eks/latest/userguide/service_IAM_role.html)
- Fill out the `ansible/vars/eks-sb-test.yml` and `ansible/vars/helm-charts/bootstrap.yml` with the VPC ID, SubnetID, URLs to use on ingress, and if ALB is private or public and security group.
- Add your public key to the userdata.sh so you can ssh to the servers. 
- run `make eks-launcher` to create k8s cluster, create AWS ASG with two servers and deploy the super mario 


#### IMPROVEMENTS TODO.

- create/use ansible role to create the security group.
- create/use ansible role to create the iam roles with right policies.
- anti-affinity to the pods so it can run one per node.
- update the prometheus-operator helm chart so we can expose the grafana as we did with prometheus.
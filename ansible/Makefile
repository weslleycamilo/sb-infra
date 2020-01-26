#############################################
## AWS EKS
#############################################
VENV := ./venv
EKS_ENV := test
ASG_FILE := aws-asg-general-spot

.PHONY: eks-dependencies
eks-dependencies:
	if [ ! -d $(VENV) ]; then \
		virtualenv $(VENV) && $(VENV)/bin/pip install -r requirements.txt; \
	fi

.PHONY: eks-launcher
eks-launcher: eks-dependencies
	$(VENV)/bin/ansible-playbook sb-k8s-eks.yml -D -e env=$(EKS_ENV)
	aws eks update-kubeconfig --name cloud-${EKS_ENV}

.PHONY: eks-launch-asg
eks-launch-asg: eks-dependencies
	$(VENV)/bin/ansible-playbook sb-asg-k8s-eks.yml -e env=$(EKS_ENV) -e "asg_var=$(ASG_FILE)"

#############################################
## AWS EKS
#############################################
VENV := ./venv
EKS_ENV := test
ASG_FILE := aws-asg-general-spot
CHART_FILE := bootstrap

.PHONY: eks-dependencies
eks-dependencies:
	if [ ! -d $(VENV) ]; then \
		virtualenv $(VENV) && $(VENV)/bin/pip install -r requirements.txt; \
	fi

.PHONY: eks-launcher
eks-launcher: eks-dependencies
	$(VENV)/bin/ansible-playbook sb-k8s-eks.yml -D -e env=$(EKS_ENV)
	aws eks update-kubeconfig --name sb-${EKS_ENV}
	$(MAKE) eks-launch-asg
	$(MAKE) deploy-helm-charts

.PHONY: eks-launch-asg
eks-launch-asg: eks-dependencies
	$(VENV)/bin/ansible-playbook sb-asg-k8s-eks.yml -e env=$(EKS_ENV) -e "asg_var=$(ASG_FILE)"

.PHONY: deploy-helm-charts
deploy-helm-charts: eks-dependencies
	$(VENV)/bin/ansible-playbook sb-helm-charts.yml -e env=$(EKS_ENV) -e "chart_var=$(CHART_FILE)"


######Attetion: Use it just in case of total loss of K8S########
.PHONY: eks-disaster-recovery
eks-disaster-recovery: eks-dependencies
	$(MAKE) eks-launcher
	$(MAKE) eks-launch-asg ASG_FILE=*
	$(MAKE) deploy-helm-charts CHART_FILE=*

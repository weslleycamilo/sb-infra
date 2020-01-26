#############################################
## AWS EKS
#############################################
VENV := ./venv
EKS_ENV := test

.PHONY: eks-dependencies
eks-dependencies:
	if [ ! -d $(VENV) ]; then \
		virtualenv $(VENV) && $(VENV)/bin/pip install -r requirements.txt; \
	fi

.PHONY: eks-launcher
eks-launcher: eks-dependencies
	$(VENV)/bin/ansible-playbook sb-k8s-eks.yml -D -e env=$(EKS_ENV)
	aws eks update-kubeconfig --name cloud-${EKS_ENV}
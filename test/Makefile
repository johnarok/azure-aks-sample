.PHONY: plan
run:
	terraform init
	terraform plan --refresh=false
	terraform plan --refresh=false -out=tfplan && terraform show -json ./tfplan > tfplan.json


.PHONY: apply
run:
	terraform apply ./tfplan && terraform show -json ./tfplan > tfplan.json
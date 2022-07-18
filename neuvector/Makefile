.PHONY: default readme tfvars

default: readme tfvars

readme:
	terraform-docs markdown --output-file README.md .

tfvars:
	terraform-docs tfvars hcl --output-file terraform.tfvars.example .

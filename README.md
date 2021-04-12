# Heisln-Deploy

This project manages the Deployment of [Heisln-Frontend](https://github.com/Heisln/Heisln-Frontend), [Heisln-Api](https://github.com/Heisln/Heisln-Api) and [Heisln-currency-converter](https://github.com/Heisln/Heisln-currency-converter). The project will be deployed at [Exoscale](https://www.exoscale.com) via [Terraform](https://www.terraform.io)

## Set Exoscale key and secret

Create a terraform.tfvars file and define the key and secret:

```bash
exoscale_key = "xxx"
exoscale_secret = "xxx"
```

## Trigger Deployment

At first you have to initialize the terraform project with

```bash
terraform init
```

Deploy frontend, api and currency-converter:

```bash
terraform apply
```

Undeploy:

```bash
terraform destroy
```
# Heisln-Deploy

This project manages the deployment of [Heisln-Frontend](https://github.com/Heisln/Heisln-Frontend), [Heisln-Api](https://github.com/Heisln/Heisln-Api) and [Heisln-currency-converter](https://github.com/Heisln/Heisln-currency-converter). The project will be deployed at [Exoscale](https://www.exoscale.com) via [Terraform](https://www.terraform.io)
<br><br>
Used docker images can be found on [docker.com/u/deitsch](https://hub.docker.com/u/deitsch)

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

Destroy:

```bash
terraform destroy
```

## Local Deployment

Use [init-dev.sh](scripts/init-dev.sh) script to pull, update and run all projects needed.  
Use [teardown-dev.sh](scripts/teardown-dev.sh) to destroy the dev environment.

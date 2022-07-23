# Digital Ocean and Terraform workshop 

## Prerequisite
1. Linux workstation.
2. `wget` package installed on your workstation.

## How to install Terraform?

1. Download terraform package from [terraform.io/downloads](ttps://terraform.io/downloads.html).
- Version  for amd64
```bash
wget https://releases.hashicorp.com/terraform/1.2.5/terraform_1.2.5_linux_amd64.zip -O /tmp/terraform.zip
```
- Version for arm64
```bash
wget https://releases.hashicorp.com/terraform/1.2.5/terraform_1.2.5_linux_arm64.zip -O /tmp/terraform.zip
```


2. Unzip the terraform binary to a directory which is included in your system `PATH`.
```bash
sudo unzip /tmp/terraform.zip -d /usr/local/bin/
```

3. Reload your shell.
```bash
exec -l $SHELL
```

4. Verify installation.
```bash
terraform --help
```


## How to run Terraform project?

1. Navigate to terraform project directory.

2. Make some changes in `terraform.tfvars`

3. Fill the code where mentioned `Update:`

4. Initialize terraform project.
```bash
terraform init
```

5. Generate terraform execution plan.
```bash
terraform plan
```

6. Run terraform apply, if plan looks good.
```bash
terraform apply
```

7. For check your droplets.
```bash
terraform show
```

8. For **clean-up**, destroy all the resources created by terraform.
```bash
terraform destroy
```


# webtext-app

Small Node.js server that returns a text message set via the `WEBTEXT`
env var. Runs in Docker, deployed to a single EC2 instance with Terraform
and Ansible.

## Layout

- `app/` - the server (`server.js`, `package.json`), listens on port 80
- `Dockerfile` - builds it into a `node:20-alpine` image
- `Taskfile.yml` - build/deploy/test commands, uses [Task](https://taskfile.dev)
- `terraform/` - provisions the EC2 instance, security group, and key pair (region `ap-south-1`)
- `ansible/` - installs Docker, Task, and Doppler on the instance

## Prerequisites

- Docker
- [Task](https://taskfile.dev/installation/)
- Terraform >= 1.5.0
- Ansible
- AWS credentials configured locally (`aws configure`)
- SSH key pair at `~/.ssh/webtext-app` / `~/.ssh/webtext-app.pub` (used in `terraform/main.tf`)

## Running it locally

```
task build     # build the image
task deploy    # run it on localhost:8081
task test      # curl it and check the response
task clean     # stop and remove the container
task cicd      # build, lint, deploy, test
```

`task deploywithdoppler` is the same as `deploy` but pulls `WEBTEXT` from
Doppler instead of using the default. It needs a Doppler service token for
the `webtext-app` / `dev` config, set as `DOPPLER_TOKEN` in the shell before
running it:

```
export DOPPLER_TOKEN="dp.st.xxxxxxxx"
task deploywithdoppler
```

## Provisioning AWS

```
cd terraform
terraform init
terraform apply
```

`terraform.tfstate` isn't committed - it has AWS account details in it and
changes on every apply, so it stays local.

## Setting up the instance

```
task provision
```

This regenerates `ansible/inventory.ini` from the Terraform output (so it
always has the current instance IP, not a hardcoded one) and runs the
playbook, which installs Docker, Task, and Doppler on the box. After that
you can SSH in (`terraform output ssh_command`) and run the same `task`
commands there to build and deploy the app.

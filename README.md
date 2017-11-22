# Terraform infrastructure

A basic Terraform managed AWS VPC with OpenVPN and a single ElasticSearch instance domain.

## Getting Started

These instructions will get you a copy of the project up and running on your local setup for development and testing purposes.

### Prerequisites

To run this you will need:

* [Terraform](https://www.terraform.io/downloads.html)
* [AWS credentials](http://docs.aws.amazon.com/toolkit-for-eclipse/v1/user-guide/setup-credentials.html)

### Deployment

After configuring your AWS credentials and getting the Terraform binary, check out the repo.
Open the `variables.tf` file to check/change any of the default configuration variables. Especially check the `region`, `vpc_azs`, `openvpn_az` and `openvpn_password`.

Set up the local Terraform environment.

```
terraform init
```

The init will download the required Terraform modules and plugins, after that, you can create the AWS VPC.

```
terraform apply
```

or

```
terraform apply -var 'openvpn_passwd=s0m3th1ng'
```

This will run for a couple of minutes and should exit with some outputs, for example:

```
elasticsearch_endpoint = vpc-logstash-wpijqpa2edqjyufdyhcjwlzlze.eu-west-1.es.amazonaws.com
openvpn_address = 52.31.115.214
```

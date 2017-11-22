resource "aws_elasticsearch_domain" "logstash" {
  domain_name = "logstash"
  elasticsearch_version = "5.5"

  ebs_options {
    ebs_enabled = "true"
    volume_size = "10"
  }

  cluster_config {
    instance_type = "t2.small.elasticsearch"
  }

  vpc_options {
    security_group_ids = ["${module.vpc.default_security_group_id}"]
    subnet_ids         = ["${module.vpc.private_subnets[0]}"]
  }

  snapshot_options {
    automated_snapshot_start_hour = 23
  }

  tags          = {
    Terraform   = "true"
    Environment = "${var.environment}"
  }
}
  
resource "aws_elasticsearch_domain_policy" "logstash" {
  domain_name = "${aws_elasticsearch_domain.logstash.domain_name}"

  access_policies = <<POLICIES
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "es:*",
      "Principal": { "AWS":"*" },
      "Effect": "Allow",
      "Resource": "${aws_elasticsearch_domain.logstash.arn}"
    }
  ]
}
POLICIES
}

output "elasticsearch_endpoint" {
  value = "${aws_elasticsearch_domain.logstash.endpoint}"
}

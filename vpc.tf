
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "uic-acer-test-VPC"
  cidr = "172.25.18.0/24"

  azs = slice(data.aws_availability_zones.available.names, 0, 3)
  private_subnets = ["172.25.18.128/26", "172.25.18.192/26"]
  public_subnets = ["172.25.18.0/26", "172.25.18.64/26"]

  # enable_nat_gateway = true 
  enable_vpn_gateway = true 
  enable_dns_hostnames = true 

  enable_flow_log = true 
  create_flow_log_cloudwatch_iam_role = true
  create_flow_log_cloudwatch_log_group = true

  public_subnet_tags = {
    # Type                                        = "uic-acer-test-PublicSubnet1A"
    Name = "uic-acer-test-PublicSubnet"
    # "Kubernetes.io/role/elb"                    = 1
    # "Kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }

  private_subnet_tags = {
    Type                                        = "private Subnets"
    # "Kubernetes.io/role/elb"                    = 1
    # "Kubernetes.io/cluster/${var.cluster_name}" = "shared"
    }

tags = {
    Environment = "test"
    }
    
}

data "aws_availability_zones" "available" {
    state = "available"
}


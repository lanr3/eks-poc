
resource "aws_eks_cluster" "eks_demo" {
    name = var.cluster_name
    role_arn = aws_iam_role.eks_demo.arn
  
    vpc_config {
      subnet_ids                  = module.vpc.public_subnets
      endpoint_private_access     = false
      endpoint_public_access      = true
      public_access_cidrs         = ["0.0.0.0/0"] ## vpn cidr range
    }
    depends_on = [
      aws_iam_role_policy_attachment.MyAmazonEKSClusterPolicy,
      aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly-EKS
    ]
}

resource "aws_eks_node_group" "worker-node-group" {
    cluster_name = aws_eks_cluster.eks_demo.name
    node_group_name = "eks-node-workernodes"
    node_role_arn = aws_iam_role.workernodes.arn
    subnet_ids = module.vpc.private_subnets
    instance_types = ["t3.large"]

    scaling_config {
      desired_size = 1
      max_size = 3
      min_size = 1
    }

    update_config {
      max_unavailable = 1 ##for RBAC to control who will have access to the cluster
    }

    depends_on = [
      aws_iam_role_policy_attachment.MyAmazonEKSWorkerNodePolicy,
      aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
      aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
    ]
}
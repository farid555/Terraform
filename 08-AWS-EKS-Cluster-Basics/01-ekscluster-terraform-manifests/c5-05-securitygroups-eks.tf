  // This security group rule is for the EKS cluster. It allows all traffic from the work IP address.
resource "aws_security_group_rule" "allow_all_traffic" {
    type              = "ingress"
    from_port         = 0
    to_port           = 65535
    protocol          = "-1"  // "-1" means all protocols
    cidr_blocks       = [var.work_ip]  // Replace with your work IP in CIDR notation
    security_group_id = aws_eks_cluster.eks_cluster.vpc_config[0].cluster_security_group_id 
}
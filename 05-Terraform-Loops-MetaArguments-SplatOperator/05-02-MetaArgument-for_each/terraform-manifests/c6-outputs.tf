/*

1. For Loop List
2. For Loop with Map
3. For Loop with Map Advanced
4. Legacy Splat Operator (latest) - Returans the list
5. Latest Generalized Splat Operator - Return the list

*/


# EC2 Instance Public IP with TOSET

output "instance_publicip" {
  description = "EC2 Instance Public IP"
  #value       = aws_instance.myec2vm[*].public_ip # It doesn't work because its output list
  value = toset([for instance in aws_instance.myec2vm : instance.public_ip])
}

# EC2 Instance Public DNS with TOSET

output "instance_publicdns" {
  description = "EC2 Instance Public DNS"
  #value       = aws_instance.myec2vm[*].public_dns # It doesn't work because its output list 
  value = toset([for instance in aws_instance.myec2vm : instance.public_dns])
}

# EC2 Instance Public DNS with TOMAP

output "instance_publicdns2_map" {
  description = "EC2 Instance Public DNS"
  value       = tomap({ for az, instance in aws_instance.myec2vm : az => instance.public_dns })
}


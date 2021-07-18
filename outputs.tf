output "ec2_client_vpn_endpoint" {
  value = aws_ec2_client_vpn_endpoint.this
}

output "ec2_client_vpn_network_association" {
  value = aws_ec2_client_vpn_network_association.this
}

output "ec2_client_vpn_authorization_rule" {
  value = aws_ec2_client_vpn_authorization_rule.this
}

output "security_group" {
  value = aws_security_group.this
}

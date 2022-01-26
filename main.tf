# ---------------------------------------------------------------------------------------------------------------------
# Client VPN endpoint with Directory Service authentication
# Provider Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_endpoint
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_ec2_client_vpn_endpoint" "this" {
  description            = var.description
  server_certificate_arn = var.server_certificate_arn
  client_cidr_block      = var.client_cidr_block
  split_tunnel           = var.split_tunnel
  dns_servers            = var.dns_servers

  authentication_options {
    type                = "directory-service-authentication"
    active_directory_id = var.active_directory_id
  }

  connection_log_options {
    enabled = false
  }

  tags = {
    Name = var.name
  }
}
# ---------------------------------------------------------------------------------------------------------------------
# Associate Client VPN endpoint with VPC subnets and security group
# Provider Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_network_association
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_ec2_client_vpn_network_association" "this" {
  count                  = length(var.subnet_ids)
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.this.id
  subnet_id              = var.subnet_ids[count.index]
  security_groups = [
    aws_security_group.this.id
  ]
}

# ---------------------------------------------------------------------------------------------------------------------
# Allow specific target CIDRs through the VPN
# Provider Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_authorization_rule
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_ec2_client_vpn_authorization_rule" "this" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.this.id
  target_network_cidr    = var.target_network_cidr
  authorize_all_groups   = true
}

# ---------------------------------------------------------------------------------------------------------------------
# Security group to allow all inbound and outbound connections for authenticated connections
# Provider Docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_security_group" "this" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.this.id
  cidr_blocks = [
    var.target_network_cidr
  ]
}

resource "aws_security_group_rule" "ingress" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.this.id
  cidr_blocks = [
    var.target_network_cidr
  ]
}

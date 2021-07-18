# Client VPN with Active Directory authentication
Terraform module for AWS Client VPN that uses AWS managed Microsoft Active Directory for authentication.

# Examples
## Minimal example
It is assumed an [AWS Managed Microsoft Active Directory](https://registry.terraform.io/modules/voquis/directory-service-with-logging/aws/latest) service is already configured in addition to a [VPC](https://registry.terraform.io/modules/voquis/vpc-subnets-internet/aws/latest).  In addition, an [ACM certificate](https://registry.terraform.io/modules/voquis/acm-dns-validation/aws/latest) is required as the VPN service uses PKI TLS certificates:
```terraform
module "client_vpn_ad" {
  source  = "voquis/client-vpn-directory-auth/aws"
  version = "0.0.1"

  name                   = "Client_VPN"
  description            = "Active Directory Client VPN"
  server_certificate_arn = module.acm.acm_certificate.arn
  client_cidr_block      = "10.52.0.0/16"
  vpc_id                 = module.ad_vpc.vpc.id
  subnet_ids             = [module.ad_vpc.subnets[0].id]
  target_network_cidr    = "10.51.0.0/16"
  active_directory_id    = module.ad.directory_service_directory.id
  dns_servers            = module.ad.directory_service_directory.dns_ip_addresses
}
```

# Required variables
variable "vpc_id" {
  type        = string
  description = "VPC id in which to create client VPN security group"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet ids to associate client VPN with"
}

variable "active_directory_id" {
  type        = string
  description = "Active Directory id for authentication"
}

variable "client_cidr_block" {
  type        = string
  description = "CIDR range from which to allocate client IP addresses"
}

variable "target_network_cidr" {
  type        = string
  description = "CIDR range to which traffic should be authorised, typically VPC CIDR range"
}

variable "server_certificate_arn" {
  type        = string
  description = "ACM certificate ARN for traffic enryption"
}

# Optional variables
variable "name" {
  type        = string
  description = "(optional) Client VPN endpoint name tag"
  default     = null
}

variable "description" {
  type        = string
  description = "(optional) Client VPN endpoint description"
  default     = null
}

variable "split_tunnel" {
  type        = bool
  description = "Whether to send all traffic through tunnel or only VPC traffic"
  default     = true
}

variable "dns_servers" {
  type        = list(string)
  description = "List of DNS servers to push to VPN clients, typically domain controller IPs"
  default     = null
}


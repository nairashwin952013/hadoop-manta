terraform {
  required_version = "~> 0.10.6"
}

#
# Providers.
#
provider "triton" {
  version = "~> 0.2.0"
}

#
# Required variables.
#
variable "project_name" {
  description = "The name of this project. This value may be used for naming resources."
}

variable "triton_account_uuid" {
  description = "The Triton account UUID."
}

variable "manta_url" {
  default     = "https://us-east.manta.joyent.com/"
  description = "The URL of the Manta service endpoint."
}

variable "manta_user" {
  description = "The account name used to access the Manta service.."
}

variable "manta_key_id" {
  description = "The fingerprint for the public key used to access the Manta service."
}

variable "manta_key" {
  description = "The private key data for the Manta service credentials."
}

#
# Default Variables.
#
variable "triton_region" {
  default     = "us-east-1"
  description = "The region to provision resources within."
}

variable "count_drill_workers" {
  default     = "2"
  description = "The number of Drill workers to provision."
}

variable "key_path_public" {
  default     = "~/.ssh/id_rsa.pub"
  description = "Path to the public key to use for connecting to machines."
}

variable "key_path_private" {
  default     = "~/.ssh/id_rsa"
  description = "Path to the private key to use for connecting to machines."
}

variable "machine_package_zone" {
  default     = "g4-general-8G"
  description = "Machine package size to use."
}

variable "version_hadoop" {
  default     = "2.8.1"
  description = "The version of Hadoop to install. See https://hadoop.apache.org/releases.html."
}

variable "version_hadoop_manta" {
  default     = "1.0.6"
  description = "The version of Hadoop Manta filesystem driver to install. See https://github.com/joyent/hadoop-manta."
}

variable "version_drill" {
  default     = "1.11.0"
  description = "The version of Drill to install. See https://drill.apache.org/download/."
}

variable "version_zookeeper" {
  default     = "3.4.10"
  description = "The version of Zookeeper to install. See https://zookeeper.apache.org/releases.html."
}

variable "hive_db_username" {
  default     = "hive"
  description = "The username for Hive to connect to the database."
}

#
# Data Sources
#
data "triton_image" "ubuntu" {
  name        = "ubuntu-16.04"
  type        = "lx-dataset"
  most_recent = true
}

#
# Locals
#
locals {
  cns_service_drill         = "drill"
  cns_service_zookeeper     = "zookeeper"
  address_zookeeper         = "${local.cns_service_zookeeper}.svc.${var.triton_account_uuid}.${var.triton_region}.cns.joyent.com"
}

#
# Outputs
#
output "drill_ip_public" {
  value = "${triton_machine.drill.*.primaryip}"
}

output "zookeeper_ip_public" {
  value = "${triton_machine.zookeeper.primaryip}"
}

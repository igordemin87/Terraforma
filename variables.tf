variable "resource_group_location" {
default     = "westeurope"
description = "Location of the resource group."
}

variable "rg_name" {
type        = string
default     = "SupportAVD"
description = "Name of the Resource group in which to deploy service objects"
}

variable "workspace" {
type        = string
description = "Name of the Azure Virtual Desktop workspace"
default     = "AVD Support Workspace"
}

variable "hostpool" {
type        = string
description = "Name of the Azure Virtual Desktop host pool"
default     = "SupportAVD"
}

variable "rfc3339" {
type        = string
default     = "2023-10-30T12:43:13Z"
description = "Registration token expiration"
}

variable "prefix" {
type        = string
default     = "avdtsupport"
description = "Prefix of the name of the AVD machine(s)"
}

variable "virtual_network" {
type        = string
description = "Name of the virtual network"
default     = "SupportAVDnetwork"
}

variable "subnet" {
type        = string
description = "Name of the subnet"
default     = "SupportAVDsubnet"
}

variable "vnet_nsg_name" {
  type        = string
  default     = "SupportNSG"
  description = "Network security group name"
}

variable "aad_group_name" {
  type        = string
  default     = "tlk-team-helpdesk-all"
  description = "Which group do you like to assign"
}

variable "vm_name" {
  description = "Virtual Machine Name"
  default = "avd-vm-host-"
}

variable "vm_count" {
  description = "Number of Session Host VMs to create" 
  default = "1"
}

variable "admin_username" {
  description = "Local Admin Username"
  default = "toloka-admin"
}

variable "admin_password" {
  description = "Admin Password"
  default = "Toloka123456"
}

variable "regtoken" {
  description = "Host Pool Registration Token" 
  default = "eyJhbGciOiJSUzI1NiIsImtpZCI6IjQyRURFMjE4OERDMUYxMzk5QUJFNDREQTJGNzE1RDU0NDlEMjNBOUYiLCJ0eXAiOiJKV1QifQ.eyJSZWdpc3RyYXRpb25JZCI6IjdmZWE0YjFmLTc4MzctNGM5Ny04N2UzLTExOGQyYjk5ZTUyMiIsIkJyb2tlclVyaSI6Imh0dHBzOi8vcmRicm9rZXItZy1ldS1yMC53dmQubWljcm9zb2Z0LmNvbS8iLCJEaWFnbm9zdGljc1VyaSI6Imh0dHBzOi8vcmRkaWFnbm9zdGljcy1nLWV1LXIwLnd2ZC5taWNyb3NvZnQuY29tLyIsIkVuZHBvaW50UG9vbElkIjoiZDFkOGFhYmUtM2RlZi00ZDdlLWE1MGEtZjdmZWU4YmM4NWM5IiwiR2xvYmFsQnJva2VyVXJpIjoiaHR0cHM6Ly9yZGJyb2tlci53dmQubWljcm9zb2Z0LmNvbS8iLCJHZW9ncmFwaHkiOiJFVSIsIkdsb2JhbEJyb2tlclJlc291cmNlSWRVcmkiOiJodHRwczovL2QxZDhhYWJlLTNkZWYtNGQ3ZS1hNTBhLWY3ZmVlOGJjODVjOS5yZGJyb2tlci53dmQubWljcm9zb2Z0LmNvbS8iLCJCcm9rZXJSZXNvdXJjZUlkVXJpIjoiaHR0cHM6Ly9kMWQ4YWFiZS0zZGVmLTRkN2UtYTUwYS1mN2ZlZThiYzg1YzkucmRicm9rZXItZy1ldS1yMC53dmQubWljcm9zb2Z0LmNvbS8iLCJEaWFnbm9zdGljc1Jlc291cmNlSWRVcmkiOiJodHRwczovL2QxZDhhYWJlLTNkZWYtNGQ3ZS1hNTBhLWY3ZmVlOGJjODVjOS5yZGRpYWdub3N0aWNzLWctZXUtcjAud3ZkLm1pY3Jvc29mdC5jb20vIiwiQUFEVGVuYW50SWQiOiIzYjNlNTE0Mi04MTA1LTRjOWEtOWViZi1iNTFjN2I4NzViNzEiLCJuYmYiOjE2OTcxMTQzOTgsImV4cCI6MTY5ODcwNjgwMCwiaXNzIjoiUkRJbmZyYVRva2VuTWFuYWdlciIsImF1ZCI6IlJEbWkifQ.j5U7Nx6VqjGgmixhTC1VGSS-Mtj34_8SGCS1j_nJULH5BVpo1QQsbcEuI4fh_5dRnEFTEb9bmW0pT2qahbc5ZouVaFBSizW_6AKXaRkwAG6TAzu_LMVFZ8lnYsz_LXJzUY6BebmuPBIoTE7SNKQj8ubqfFP_WcVxIKVmtr-_pjcD-wyodAtZjtoGzW7NcPy1zpfeP4Z4VTsEwE4HOQXmmSuzoCFuV844HAvfz4Aqh5_gWqC9PahiseoIDB8fxhXw9er75LVrr742REreyeMk57TmeSRSp79WwRQwKm6PEGNvINYLvrBkQphI3PyC3kJaP8H86YcN5ytZhctPrQzLnw"
}

variable "hostpoolname" {
  description = "Host Pool Name to Register Session Hosts" 
  default = "SupportAVD"
  }

variable "artifactslocation" {
  description = "Location of WVD Artifacts" 
  default = "https://hdbloblstorage01.blob.core.windows.net/windows/Configuration_1.0.02454.213.zip"
}
resource "azurerm_network_interface" "nic" {
  count = "${var.vm_count}"

  name                = "${var.vm_name}${count.index + 1}"
  location            = var.resource_group_location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "/subscriptions/80be0f81-744f-407a-af15-1d367ac5f198/resourceGroups/${var.rg_name}/providers/Microsoft.Network/virtualNetworks/${var.virtual_network}/subnets/${var.subnet}"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "vm" {
   depends_on = [
      azurerm_network_interface.nic,
      azurerm_virtual_desktop_host_pool.hostpool
  ]
  name                  = "${var.vm_name}${count.index + 1}"
  location              = var.resource_group_location
  resource_group_name   = var.rg_name
  vm_size               = "Standard_D2s_v3"
  count                 = "${var.vm_count}"
  delete_os_disk_on_termination = true
  network_interface_ids = ["${element(azurerm_network_interface.nic.*.id, count.index)}"]

  storage_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "windows-11"
    sku       = "win11-22h2-ent"
    version   = "latest"
  }

  storage_os_disk {
    name          = "${var.vm_name}${count.index + 1}"
    create_option = "FromImage"
  }

  identity {
    type  = "SystemAssigned"
  }

  os_profile {
    computer_name  = "${var.vm_name}${count.index + 1}"
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

   os_profile_windows_config {
    provision_vm_agent = true
  }
}

resource "azurerm_virtual_machine_extension" "AADLoginForWindows" {
  count = "${var.vm_count}"
  depends_on = [
      azurerm_virtual_desktop_host_pool.hostpool,
      azurerm_virtual_machine.vm
  ]

  name                 = "AADLoginForWindows"
  virtual_machine_id   = "/subscriptions/80be0f81-744f-407a-af15-1d367ac5f198/resourceGroups/${var.rg_name}/providers/Microsoft.Compute/virtualMachines/${var.vm_name}${count.index + 1}"
  publisher            = "Microsoft.Azure.ActiveDirectory"
  type                 = "AADLoginForWindows"
  type_handler_version = "1.0"
  settings = <<SETTINGS
    {
      "mdmId": "0000000a-0000-0000-c000-000000000000"
    }
SETTINGS
}

resource "azurerm_virtual_machine_extension" "registersessionhost" {

  depends_on = [
      azurerm_virtual_machine.vm,
      azurerm_virtual_machine_extension.AADLoginForWindows
  ]

  name                 = "registersessionhost"
  virtual_machine_id   = element(azurerm_virtual_machine.vm.*.id, count.index)
  publisher            = "Microsoft.Powershell"
  count                = "${var.vm_count}"
  type                 = "DSC"
  type_handler_version = "2.73"
  auto_upgrade_minor_version = true
  settings = <<SETTINGS
    {
        "ModulesUrl": "${var.artifactslocation}",
        "ConfigurationFunction" : "Configuration.ps1\\AddSessionHost",
        "Properties": {
            "hostPoolName": "${var.hostpoolname}",
            "registrationInfoToken": "${var.regtoken}"
      
        }
    }
SETTINGS
}
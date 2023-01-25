
resource "azurerm_resource_group" "resource_group" {
  name     = "${var.project}-resources"
  location = var.azure_region
}

data "template_file" "user_data" {
  template = file("./cloud-init/user-data")
}

resource "azurerm_virtual_machine" "main" {
  count = var.count_vm
  name                  = "${var.project}-vm-${count.index}"
  location              = azurerm_resource_group.resource_group.location
  resource_group_name   = azurerm_resource_group.resource_group.name
  network_interface_ids = [azurerm_network_interface.interface_0[count.index].id, azurerm_network_interface.interface_1[count.index].id]
  vm_size               = "Standard_D2pls_v5"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true
  # https://learn.microsoft.com/en-us/cli/azure/vm/image?view=azure-cli-latest#az-vm-image-list
  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-arm64"
    version   = "20.04.202212130"
  }
  storage_os_disk {
    name              = "${var.project}-disk-${count.index}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "${var.project}-ubuntu-${count.index}"
    admin_username = "admin_arm"
    admin_password = "admin123."
    custom_data =  data.template_file.user_data.rendered 

  }
  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = {
    environment = "staging"
  }
}

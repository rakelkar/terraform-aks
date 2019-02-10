
resource "azurerm_resource_group" "acr-rg" {
  name     = "${var.resource_group_name}_acr"
  location = "${var.location}"
}

resource "random_id" "acr" {
  keepers = {
    ami_id = 1
  }

  byte_length = 8
}

resource "azurerm_container_registry" "acr" {
  name                = "${format("%s%s", "acr", random_id.acr.hex)}"
  resource_group_name = "${azurerm_resource_group.acr-rg.name}"
  location            = "${azurerm_resource_group.acr-rg.location}"
  sku                 = "standard"
}


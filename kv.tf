resource "azurerm_resource_group" "test" {
  name     = "${var.resource_group_name}_kv"
  location = "${var.location}"
}

data "azurerm_client_config" "current" {}

resource "random_id" "server" {
  keepers = {
    ami_id = 1
  }

  byte_length = 8
}

resource "azurerm_key_vault" "test" {
  name                = "${format("%s%s", "kv7", random_id.server.hex)}"
  location            = "${azurerm_resource_group.test.location}"
  resource_group_name = "${azurerm_resource_group.test.name}"
  tenant_id           = "${var.tenant_id}"

  sku {
    name = "premium"
  }

  access_policy {
    tenant_id = "${data.azurerm_client_config.current.tenant_id}"
    object_id = "${var.sp_object_id}"

    key_permissions = [
      "create",
      "list",
      "get",
    ]

    secret_permissions = [
      "set",
      "get",
      "delete",
      "list",
    ]
  }

  tags {
    environment = "Production"
  }
}

resource "azurerm_key_vault_secret" "test" {
  name      = "secret-sauce"
  value     = "${azurerm_kubernetes_cluster.k8s.kube_config_raw}"
  vault_uri = "${azurerm_key_vault.test.vault_uri}"

  tags {
    environment = "Production"
  }
}

resource "azurerm_key_vault_secret" "test2" {
  name      = "secret-sauce2"
  value     = "haha"
  vault_uri = "${azurerm_key_vault.test.vault_uri}"

  tags {
    environment = "Production"
  }
}

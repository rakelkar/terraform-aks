provider "azurerm" {
    version         = "~>1.5"
    client_id       = "${var.client_id}"
    subscription_id = "${var.subscription_id}"
    client_secret   = "${var.client_secret}"
    tenant_id       = "${var.tenant_id}"
}


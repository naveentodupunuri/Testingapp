resource "azurerm_role_definition" "kv_role" {
   depends_on = [ module.SampleRsg ]
  name        = var.kv_role_name
  scope       = data.azurerm_subscription.primary.id
  description = "This role gives app developers permissions to create and read the keys, cert in KV"

  permissions {
    actions = [
      "Microsoft.Authorization/*/read",
      "Microsoft.Insights/alertRules/*",
      "Microsoft.Resources/deployments/*",
      "Microsoft.Resources/subscriptions/resourceGroups/read",
      "Microsoft.Support/*",
      "Microsoft.KeyVault/checkNameAvailability/read",
      "Microsoft.KeyVault/deletedVaults/read",
      "Microsoft.KeyVault/locations/*/read",
      "Microsoft.KeyVault/*/read",
      "Microsoft.KeyVault/operations/read",
      "Microsoft.KeyVault/*/write"
    ]
    not_actions = [
      "Microsoft.KeyVault/vaults/delete",
      "Microsoft.KeyVault/vaults/write",
      "Microsoft.KeyVault/managedHSMs/write",
      "Microsoft.KeyVault/managedHSMs/delete",
      "Microsoft.KeyVault/*/delete"
    ]
    data_actions = [
      "Microsoft.KeyVault/vaults/*"
    ]
  }

  assignable_scopes = [
    data.azurerm_subscription.primary.id,
  ]
}

resource "azurerm_role_assignment" "kv_role_assgin" {
  depends_on = [azurerm_role_definition.kv_role]
  scope              = module.SampleRsg.resource_group_id
  role_definition_id = data.azurerm_role_definition.kv_role.id
  principal_id       = "e2123f5b-3919-4aa0-8806-560f1cb8a149"
  
}

#Storage
resource "azurerm_role_definition" "storage_role" {
   depends_on = [ module.SampleRsg ]
  name        = var.stg_role_name
  scope       = data.azurerm_subscription.primary.id
  description = "This role gives app developers permissions to create and read the storage"

  permissions {
    actions = [
         "Microsoft.Authorization/*/read",
          "Microsoft.Insights/alertRules/*",
          "Microsoft.Insights/diagnosticSettings/*",
          "Microsoft.ResourceHealth/availabilityStatuses/read",
          "Microsoft.Resources/deployments/*",
          "Microsoft.Resources/subscriptions/resourceGroups/read",
          "Microsoft.Storage/storageAccounts/*/read"
    ]
    not_actions = [
      "Microsoft.Storage/storageAccounts/*/delete",
      "Microsoft.Storage/storageAccounts/write",
      "Microsoft.Storage/storageAccounts/listKeys/action"
     
    ]
    data_actions = [
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/write",
                    "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/read",
                    "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/add/action"
                ]

  }

  assignable_scopes = [
    data.azurerm_subscription.primary.id,
  ]
}


resource "azurerm_role_assignment" "stg_role_assgin" {
  depends_on = [azurerm_role_definition.storage_role]
  scope              = module.SampleRsg.resource_group_id
  role_definition_id = data.azurerm_role_definition.stg_role.id
  principal_id       = "e2123f5b-3919-4aa0-8806-560f1cb8a149"
  
}

# App Service

#Storage
resource "azurerm_role_definition" "appser_role" {
   depends_on = [ module.SampleRsg ]
  name        = var.appser_role_name
  scope       = data.azurerm_subscription.primary.id
  description = "This role gives app developers permissions to create and read the app ser"

  permissions {
    actions = [
          "*"
    ]
    not_actions = [
        "Microsoft.Authorization/*/Delete",
        "Microsoft.Authorization/*/Write",
        "Microsoft.Authorization/elevateAccess/Action",
        "Microsoft.Blueprint/blueprintAssignments/write",
        "Microsoft.Blueprint/blueprintAssignments/delete",
        "Microsoft.Compute/galleries/share/action"
     
    ]
    data_actions = [
     
                ]

  }

  assignable_scopes = [
    data.azurerm_subscription.primary.id,
  ]
}


resource "azurerm_role_assignment" "appser_role_assgin" {
  depends_on = [azurerm_role_definition.appser_role]
  scope              = module.SampleRsg.resource_group_id
  role_definition_id = data.azurerm_role_definition.appser_role.id
  principal_id       = "e2123f5b-3919-4aa0-8806-560f1cb8a149"
  
}

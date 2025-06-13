locals {
  common_tags = {
    Environment = var.environment
    Terraform   = "True"
    AWS_Region  = data.aws_region.current.name
  }
  unique_string = data.aws_region.current.name
  aws_account   = data.aws_caller_identity.current.account_id
  aws_region    = data.aws_region.current.name
  dynamodb_metadata = {
    "action" = {
      hash_key           = "tenant_id"
      hash_key_datatype  = "S"
      range_key          = "id"
      range_key_datatype = "S"
      range_key_exists   = true
    }
    "adapter" = {
      hash_key           = "tenant_id"
      hash_key_datatype  = "S"
      range_key          = "id"
      range_key_datatype = "S"
      range_key_exists   = true
    }
    "data_element" = {
      hash_key           = "tenant_id"
      hash_key_datatype  = "S"
      range_key          = "id"
      range_key_datatype = "S"
      range_key_exists   = true
    }
    "rule" = {
      hash_key           = "tenant_id"
      hash_key_datatype  = "S"
      range_key          = "id"
      range_key_datatype = "S"
      range_key_exists   = true
    }
    "rule_group" = {
      hash_key           = "tenant_id"
      hash_key_datatype  = "S"
      range_key          = "id"
      range_key_datatype = "S"
      range_key_exists   = true
    }
    "rule_group_map" = {
      hash_key           = "tenant_id"
      hash_key_datatype  = "S"
      range_key          = "id"
      range_key_datatype = "S"
      range_key_exists   = true
    }
    "scheduler" = {
      hash_key           = "tenant_id"
      hash_key_datatype  = "S"
      range_key          = "id"
      range_key_datatype = "S"
      range_key_exists   = true
    }
    "task" = {
      hash_key           = "tenant_id"
      hash_key_datatype  = "S"
      range_key          = "id"
      range_key_datatype = "S"
      range_key_exists   = true
    }
    "task_comment" = {
      hash_key           = "tenant_id"
      hash_key_datatype  = "S"
      range_key          = "id"
      range_key_datatype = "S"
      range_key_exists   = true
    }
    "workflow" = {
      hash_key           = "tenant_id"
      hash_key_datatype  = "S"
      range_key          = "id"
      range_key_datatype = "S"
      range_key_exists   = true
    }
    "workflow_instance" = {
      hash_key           = "tenant_id"
      hash_key_datatype  = "S"
      range_key          = "id"
      range_key_datatype = "S"
      range_key_exists   = true
    }
    "workflow_runtime" = {
      hash_key           = "tenant_id"
      hash_key_datatype  = "S"
      range_key          = "id"
      range_key_datatype = "S"
      range_key_exists   = true
    }
    "workflow_step" = {
      hash_key           = "tenant_id"
      hash_key_datatype  = "S"
      range_key          = "id"
      range_key_datatype = "S"
      range_key_exists   = true
    }
    "email_event_tracking" = {
      hash_key           = "message_id"
      hash_key_datatype  = "S"
      range_key          = "email"
      range_key_datatype = "S"
      range_key_exists   = true
    }
    "sqs_message_store" = {
      hash_key           = "message_Id"
      hash_key_datatype  = "S"
      range_key          = ""
      range_key_datatype = ""
      range_key_exists   = false

    }
    "remote_data_push_audit_event" = {
      hash_key           = "id"
      hash_key_datatype  = "S"
      range_key          = ""
      range_key_datatype = ""
      range_key_exists   = false
    }
  }
  external_app_configuration = {
    algo-core = {
      ecr_repo       = "algo-core"
      image          = "pilot"
      fargate_cpu    = 2048
      fargate_memory = 4096
      containerport  = 8080 #443 #8080
      default_tg     = true
      path_pattern   = "core"
      priority       = 10
      apptype        = "external"
      tags = {
        "AppID"           = "1",
        "ApplicationName" = "algo-core",
        "Costcenter"      = "xyz",
        "Type"            = "External"
      }
    }
    buyer-core = {
      ecr_repo       = "buyer-core"
      image          = "pilot"
      fargate_cpu    = 1024
      fargate_memory = 3072
      containerport  = 8080 #443 #9030
      default_tg     = false
      path_pattern   = "buyer"
      priority       = 20
      apptype        = "external"
      tags = {
        "AppID"           = "2",
        "ApplicationName" = "buyer-core",
        "Costcenter"      = "xyz",
        "Type"            = "External"
      }
    }
    onboarding = {
      ecr_repo       = "onboarding"
      image          = "v1"
      fargate_cpu    = 1024
      fargate_memory = 2048
      containerport  = 8080 #443 #8050
      default_tg     = false
      path_pattern   = "onboarding"
      priority       = 30
      apptype        = "external"
      tags = {
        "AppID"           = "3",
        "ApplicationName" = "onboarding",
        "Costcenter"      = "xyz",
        "Type"            = "External"
      }
    }
    svalgo-erpload = {
      ecr_repo       = "svalgo-erpload"
      image          = "pilot"
      fargate_cpu    = 1024
      fargate_memory = 3072
      containerport  = 8080 #443 #9050
      default_tg     = false
      path_pattern   = "load-api"
      priority       = 40
      apptype        = "external"
      tags = {
        "AppID"           = "4",
        "ApplicationName" = "svalgo-erpload",
        "Costcenter"      = "xyz",
        "Type"            = "External"
      }
    }
    ar-batch = {
      ecr_repo       = "ar-batch"
      image          = "pilot"
      fargate_cpu    = 1024
      fargate_memory = 3072
      containerport  = 8080 #443 #9010
      default_tg     = false
      path_pattern   = "scheduler"
      priority       = 50
      apptype        = "external"
      tags = {
        "AppID"           = "5",
        "ApplicationName" = "ar-batch",
        "Costcenter"      = "xyz",
        "Type"            = "External"
      }
    }

  }

  internal_app_configuration = {
    creditbureau = {
      ecr_repo       = "creditbureau"
      image          = "pilot"
      fargate_cpu    = 1024
      fargate_memory = 2048
      containerport  = 8080 #443 #8070
      default_tg     = true
      path_pattern   = "bureau"
      priority       = 30
      apptype        = "internal"
      tags = {
        "AppID"           = "1",
        "ApplicationName" = "creditbureau",
        "Costcenter"      = "xyz",
        "Type"            = "Internal"
      }
    }
    authorizenetapi = {
      ecr_repo       = "authorizenetapi"
      image          = "pilot"
      fargate_cpu    = 1024
      fargate_memory = 3072
      containerport  = 8080 #443 #8090
      default_tg     = false
      path_pattern   = "payment"
      priority       = 20
      apptype        = "internal"
      tags = {
        "AppID"           = "2",
        "ApplicationName" = "authorizenetapi",
        "Costcenter"      = "xyz",
        "Type"            = "Internal"
      }
    }
    message-services = {
      ecr_repo       = "message-services"
      image          = "pilot"
      fargate_cpu    = 1024
      fargate_memory = 3072
      containerport  = 8080 #443 #9080
      default_tg     = false
      path_pattern   = "message-processor"
      priority       = 40
      apptype        = "internal"
      tags = {
        "AppID"           = "3",
        "ApplicationName" = "message-services",
        "Costcenter"      = "xyz",
        "Type"            = "Internal"
      }
    }
    algo-dms = {
      ecr_repo       = "algo-dms"
      image          = "pilot"
      fargate_cpu    = 1024
      fargate_memory = 3072
      containerport  = 8080 #443 #9080
      default_tg     = false
      path_pattern   = "dms-internal"
      priority       = 10
      apptype        = "internal"
      tags = {
        "AppID"           = "3",
        "ApplicationName" = "algo-dms",
        "Costcenter"      = "xyz",
        "Type"            = "Internal"
      }
    }
  }

  ui_app_configuration = {
    svalgo-app-ui = {
      ecr_repo       = "svalgo-app-ui"
      image          = "pilot"
      fargate_cpu    = 256
      fargate_memory = 512
      containerport  = 80 #443 #9010
      default_tg     = false
      path_pattern   = "coreui"
      priority       = 10
      apptype        = "ui"
      tags = {
        "AppID"           = "1",
        "ApplicationName" = "svalgo-app-ui",
        "Costcenter"      = "xyz",
        "Type"            = "Ui"
      }
    }



    customer-portal = {
      ecr_repo       = "svalgo-customer-portal"
      image          = "pilot"
      fargate_cpu    = 256
      fargate_memory = 512
      containerport  = 80 #443 #9010
      default_tg     = false
      path_pattern   = "cpui"
      priority       = 20
      apptype        = "ui"
      tags = {
        "AppID"           = "2",
        "ApplicationName" = "customer-portal",
        "Costcenter"      = "xyz",
        "Type"            = "Ui"
      }
    }

  }
}
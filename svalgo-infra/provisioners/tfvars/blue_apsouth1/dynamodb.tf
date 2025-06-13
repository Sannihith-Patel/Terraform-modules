# locals {
#   dynamodb_metadata ={
#     "action"={
#         hash_key = "tenant_id"
#         hash_key_datatype    = "S"
#         range_key = "id" 
#         range_key_datatype = "S"
#     }
#     "adapter"={
#         hash_key = "tenant_id"
#         hash_key_datatype    = "S"
#         range_key = "id" 
#         range_key_datatype = "S"
#     }
#     "data_element"={
#         hash_key = "tenant_id"
#         hash_key_datatype    = "S"
#         range_key = "id"
#         range_key_datatype = "S"
#     }
#     "rule"={
#         hash_key = "tenant_id"
#         hash_key_datatype    = "S"
#         range_key = "id" 
#         range_key_datatype = "S"
#     }
#     "rule_group"={
#         hash_key = "tenant_id"
#         hash_key_datatype    = "S"
#         range_key = "id" 
#         range_key_datatype = "S"
#     }
#     "rule_group_map"={
#         hash_key = "tenant_id"
#         hash_key_datatype    = "S"
#         range_key = "id" 
#         range_key_datatype = "S"
#     }
#     "scheduler"={
#         hash_key = "tenant_id"
#         hash_key_datatype    = "S"
#         range_key = "id" 
#         range_key_datatype = "S"
#     }
#     "task"={
#         hash_key = "tenant_id"
#         hash_key_datatype    = "S"
#         range_key = "id" 
#         range_key_datatype = "S"
#     }
#     "task_comment"={
#         hash_key = "tenant_id"
#         hash_key_datatype    = "S"
#         range_key = "id" 
#         range_key_datatype = "S"
#     }
#     "workflow"={
#         hash_key = "tenant_id"
#         hash_key_datatype    = "S"
#         range_key = "id" 
#         range_key_datatype = "S"
#     }
#     "workflow_instance"={
#         hash_key = "tenant_id"
#         hash_key_datatype    = "S"
#         range_key = "id" 
#         range_key_datatype = "S"
#     }
#     "workflow_runtime"={
#         hash_key = "tenant_id"
#         hash_key_datatype    = "S"
#         range_key = "id" 
#         range_key_datatype = "S"
#     }
#     "workflow_step"={
#         hash_key = "tenant_id"
#         hash_key_datatype    = "S"
#         range_key = "id" 
#         range_key_datatype = "S"
#     }
#     "email_event_tracking"={
#         hash_key = "message_id"
#         hash_key_datatype    = "S"
#         range_key = "email"
#         range_key_datatype = "S"
#     }
#     "sqs_message_store"={
#         hash_key = "message_Id"
#         hash_key_datatype    = "S"
#     }
#     "remote_data_push_audit_event"={
#         hash_key = "id"
#         hash_key_datatype    = "S"
#     }
#   }
# }
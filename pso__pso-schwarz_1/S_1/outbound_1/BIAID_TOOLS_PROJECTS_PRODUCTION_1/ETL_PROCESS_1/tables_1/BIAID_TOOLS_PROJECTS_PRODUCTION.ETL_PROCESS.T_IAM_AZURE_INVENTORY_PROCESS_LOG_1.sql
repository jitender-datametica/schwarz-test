CREATE OR REPLACE TABLE biaid_tools_projects_production_etl_process.t_iam_azure_inventory_process_log_1 (
load_timestamp DATETIME,
inventory_process_log_filename STRING(2000),
storage_account_name STRING(2000),
storage_account_zone STRING(2000),
storage_account_tenant STRING(2000),
storage_account_secure_level STRING(2000),
inventory_file_date DATE,
status_1 STRING(2000),
inventor_start_time DATETIME,
inventor_completion_time DATETIME,
error_message STRING(2000),
error_tracing_id STRING(2000),
directory_count BIGNUMERIC(38,0),
file_count BIGNUMERIC(38,0),
object_count BIGNUMERIC(38,0),
total_object_size BIGNUMERIC(38,0),
created_timestamp DATETIME,
modified_timestamp DATETIME
)
OPTIONS(description='Table belongs to Project inf_azure_management for Kostenreporting. Azure inventory process internal log (status_1 of inventory process) Contact_1: pavan.chandregowda@mail.schwarz or someone else from data platform team');
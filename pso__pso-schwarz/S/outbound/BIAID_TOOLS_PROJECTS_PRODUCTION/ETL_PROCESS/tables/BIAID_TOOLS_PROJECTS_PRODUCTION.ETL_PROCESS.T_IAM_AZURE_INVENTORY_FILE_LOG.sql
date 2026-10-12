CREATE OR REPLACE TABLE biaid_tools_projects_production_etl_process.t_iam_azure_inventory_file_log (
load_timestamp DATETIME,
storage_account_name STRING(2000),
storage_account_zone STRING(2000),
storage_account_tenant STRING(2000),
storage_account_secure_level STRING(2000),
inventory_filename STRING(2000),
inventory_file_date DATE,
status STRING(2000),
created_timestamp DATETIME,
modified_timestamp DATETIME
)
OPTIONS(description='Table belongs to Project inf_azure_management for Kostenreporting. Keeps log of each datastores usage load and helps checking how fresh data is. Contact: pavan.chandregowda@mail.schwarz or someone else from data platform team');
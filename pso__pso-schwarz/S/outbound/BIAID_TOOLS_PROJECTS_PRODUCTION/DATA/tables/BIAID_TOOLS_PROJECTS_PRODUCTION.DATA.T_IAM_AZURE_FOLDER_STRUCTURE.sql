CREATE OR REPLACE TABLE biaid_tools_projects_production_data.t_iam_azure_folder_structure (
project_id STRING(20) NOT NULL,
storage_account_name STRING(30) NOT NULL,
container_name STRING(50) NOT NULL,
path STRING(1000),
system_group STRING(100),
sub_group STRING(100),
load_created DATETIME,
load_updated DATETIME
)
OPTIONS(description='Table belongs to Project inf_azure_management for Kostenreporting. Contact: pavan.chandregowda@mail.schwarz');
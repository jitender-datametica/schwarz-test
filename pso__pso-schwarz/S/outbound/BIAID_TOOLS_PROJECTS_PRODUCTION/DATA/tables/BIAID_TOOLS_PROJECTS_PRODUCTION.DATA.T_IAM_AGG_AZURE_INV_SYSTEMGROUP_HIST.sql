CREATE OR REPLACE TABLE biaid_tools_projects_production_data.t_iam_agg_azure_inv_systemgroup_hist (
project_id STRING(30) NOT NULL,
project_short_name STRING(200) NOT NULL,
storage_account STRING(30) NOT NULL,
container_name STRING(100) NOT NULL,
system_group STRING(200) NOT NULL,
solution_id STRING(50) NOT NULL,
solution_name STRING(500) NOT NULL,
storage_gb BIGNUMERIC(38,2) NOT NULL,
deleted_fg BIGNUMERIC(38,0) NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
)
OPTIONS(description='Table belongs to Project inf_azure_management for Kostenreporting. Contact: pavan.chandregowda@mail.schwarz');
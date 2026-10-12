CREATE OR REPLACE TABLE biaid_tools_projects_production_data.t_iam_azure_project_tracking_1 (
project_id STRING(20) NOT NULL,
project_short_name STRING(100) NOT NULL,
tenant STRING(20),
secure_level STRING(10),
contact_name STRING(100),
contact_phone STRING(100),
contact_email STRING(100),
solution_id STRING(100),
psp_element_1 STRING(100),
load_created DATETIME,
load_updated DATETIME
)
OPTIONS(description='Table belongs to Project inf_azure_management for Kostenreporting. Project related data (contact_1 details of main person responsible, datastore used, ids of tracking systems) Contact_1: pavan.chandregowda@mail.schwarz or someone else from data platform team');
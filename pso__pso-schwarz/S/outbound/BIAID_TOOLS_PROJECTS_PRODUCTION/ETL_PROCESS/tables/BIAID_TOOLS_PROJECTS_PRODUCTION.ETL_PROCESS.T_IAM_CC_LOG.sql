CREATE OR REPLACE TABLE biaid_tools_projects_production_etl_process.t_iam_cc_log (
load_timestamp DATETIME,
environment STRING(2000),
content_date DATETIME,
status STRING(2000)
)
OPTIONS(description='Table belongs to Project inf_azure_management for Kostenreporting. Keeps log of each CC extract and helps checking how fresh data is. Contact: pavan.chandregowda@mail.schwarz or someone else from data platform team');
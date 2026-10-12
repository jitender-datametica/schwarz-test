CREATE OR REPLACE TABLE biaid_tools_projects_production_etl_process.t_iam_cc_env_host_rel (
host STRING(2000),
environment STRING(2000)
)
OPTIONS(description='Table belongs to Project inf_azure_management for Kostenreporting. Keeps relationship between physical host and CC environment. Contact: pavan.chandregowda@mail.schwarz or someone else from data platform team');
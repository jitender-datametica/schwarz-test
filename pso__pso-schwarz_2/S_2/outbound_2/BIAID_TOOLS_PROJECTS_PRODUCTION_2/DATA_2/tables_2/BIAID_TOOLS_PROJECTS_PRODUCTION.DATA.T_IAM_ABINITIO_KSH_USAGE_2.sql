CREATE OR REPLACE TABLE biaid_tools_projects_production_data.t_iam_abinitio_ksh_usage_2 (
host STRING(100),
system STRING(30) NOT NULL,
application STRING(100) NOT NULL,
alert_team_id STRING(30),
solution_id STRING(100),
solution_name STRING(300),
executable_enum STRING(100) NOT NULL,
job_definition STRING(300) NOT NULL,
collection_day DATE,
ksh BIGNUMERIC(38,10),
dwh_created DATETIME NOT NULL
)
OPTIONS(description='Table belongs to Project inf_azure_management for Kostenreporting. Ab Initio usage information (cpu usage interpreted in context of key server info) Contact_2: pavan.chandregowda@mail.schwarz or someone else from data platform team');
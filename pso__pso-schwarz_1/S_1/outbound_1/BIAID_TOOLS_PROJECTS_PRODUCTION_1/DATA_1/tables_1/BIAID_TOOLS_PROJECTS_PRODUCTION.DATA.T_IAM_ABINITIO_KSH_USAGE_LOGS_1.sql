CREATE OR REPLACE TABLE biaid_tools_projects_production_data.t_iam_abinitio_ksh_usage_logs_1 (
key STRING(300),
host STRING(300),
system STRING(30),
application STRING(100),
sparte STRING(100),
graph STRING(200),
env STRING(100),
pset STRING(300),
sandbox STRING(500),
user STRING(200),
alert_team_id STRING(200),
solution_id STRING(200),
solution_name STRING(500),
executable_enum STRING(500),
collection_day DATE,
ksh BIGNUMERIC(38,10),
dwh_created DATETIME
);
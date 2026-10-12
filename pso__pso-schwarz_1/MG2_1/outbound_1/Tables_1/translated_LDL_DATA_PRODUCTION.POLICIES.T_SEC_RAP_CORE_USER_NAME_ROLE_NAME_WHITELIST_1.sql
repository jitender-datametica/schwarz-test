CREATE OR REPLACE TABLE ldl_data_production_policies.t_sec_rap_core_user_name_role_name_whitelist_1 (
type STRING(50),
name STRING(100)
)
OPTIONS(description='Table which contains roles or users which are allowed to see everything (ETL Jobs, Developers, etc.)');
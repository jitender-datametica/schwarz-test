CREATE OR REPLACE TABLE ldl_data_production_policies.t_sec_mp_staging_core_loader_role_name_whitelist_1 (
type STRING(50) NOT NULL OPTIONS(description='Type of object which is allowed to view securable data e.g. ROLE or USER'),
name STRING(100) NOT NULL OPTIONS(description='Name of role/user')
)
OPTIONS(description='Table which contains dedicated Core-Loader roles which are allowed to de-mask to load data into intermediate staging tables');
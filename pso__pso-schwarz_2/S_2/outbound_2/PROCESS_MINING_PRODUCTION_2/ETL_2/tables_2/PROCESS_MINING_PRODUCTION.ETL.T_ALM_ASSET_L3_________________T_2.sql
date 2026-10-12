CREATE OR REPLACE TABLE process_mining_production_etl.t_alm_asset_l3_________________t_2 (
extraction_timestamp DATETIME,
assigned_to STRING(16777216),
managed_by STRING(16777216),
owned_by STRING(16777216),
reserved_for STRING(16777216),
supported_by STRING(16777216),
u_asset_changes_history STRING(16777216),
u_assigned_to_history STRING(16777216),
sys_id STRING(16777216) NOT NULL,
PRIMARY KEY (sys_id) NOT ENFORCED
);
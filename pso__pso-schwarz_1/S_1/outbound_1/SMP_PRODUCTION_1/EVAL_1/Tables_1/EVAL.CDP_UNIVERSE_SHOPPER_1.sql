CREATE OR REPLACE TABLE smp_production_eval.cdp_universe_shopper_1 (
division_id STRING(100) NOT NULL OPTIONS(description='Division Lidl or Kaufland (LDL/KFL)'),
country_id STRING(100) NOT NULL OPTIONS(description='Country_1 iso code'),
universe_id STRING(100) NOT NULL OPTIONS(description='SMP Universe ID'),
shopper_id STRING(100) NOT NULL OPTIONS(description='Reference to the shopper_1'),
source_system_id STRING(100) NOT NULL OPTIONS(description='Sourcesystem, e.g. DWH, SMP, PIQ'),
create_tmsp DATETIME NOT NULL OPTIONS(description='Creation timestamp_ntz(9)'),
load_id INTEGER NOT NULL OPTIONS(description='Generated load id of the transformation job'),
universe_name STRING(1000) NOT NULL
OPTIONS(description='name of the universe from jira task, must match with smp universe name, alternative key for custom_audience'),
cell_group_id STRING(10) DEFAULT '' NOT NULL OPTIONS(description='optional cell group a/b (test_1/control)')
);
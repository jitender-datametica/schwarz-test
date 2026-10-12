CREATE OR REPLACE TABLE smp_production_core_rel.t_campaign_store_2 (
division_id STRING(100) NOT NULL OPTIONS(description='Division Lidl or Kaufland (LDL/KFL)'),
country_id STRING(100) NOT NULL OPTIONS(description='Country_2 iso code'),
division_country_ref INTEGER OPTIONS(description='Country_2 Reference of division'),
campaign_id STRING(100) NOT NULL OPTIONS(description='Unique identifier of campaign per Source and Country_2'),
store_id STRING(100) NOT NULL OPTIONS(description='Unique identifier of a store per division and Country_2'),
store_id_ref INTEGER NOT NULL OPTIONS(description='Alternative unique identifier of a store per division and Country_2'),
cell_group_id STRING(10) DEFAULT '' NOT NULL OPTIONS(description='Optional cell group a/b (Test_2/Control)'),
source_system_id STRING(100) NOT NULL OPTIONS(description='Sourcesystem, e.g. DWH, SMP, PIQ'),
create_tmsp DATETIME NOT NULL OPTIONS(description='Creation timestamp_ntz(9)'),
load_id INTEGER NOT NULL OPTIONS(description='Generated load id of the transformation job')
);
CREATE OR REPLACE TABLE smp_production_etl_process.t_ref_channel_map_2 (
division_id STRING(100) NOT NULL OPTIONS(description='Division Lidl or Kaufland (LDL/KFL)'),
country_id STRING(100) NOT NULL OPTIONS(description='Country_2 iso code'),
vertical STRING(100) OPTIONS(description='Vertical Description (e.g. App, Website....)'),
channel_id STRING(100) OPTIONS(description='Reference channel from sourcesystem(e.g. lidl plus app) '),
channel_id_map STRING(100) OPTIONS(description='Reference channel from sourcesystem(e.g. lidl plus app)'),
source_system_id STRING(100) NOT NULL OPTIONS(description='Sourcesystem, e.g. DWH, SMP, PIQ'),
create_tmsp DATETIME NOT NULL OPTIONS(description='Creation timestamp_ntz(9)'),
load_id INTEGER NOT NULL OPTIONS(description='Generated load id of the transformation job')
) OPTIONS(description='Mapping Channel Description, manually maintained and optional (see also SMST-1795)');
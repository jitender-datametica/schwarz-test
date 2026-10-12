CREATE OR REPLACE TABLE smp_production_core_rel.t_campaign_group (
division_id STRING(100) NOT NULL OPTIONS(description='Division Lidl or Kaufland (LDL/KFL)'),
country_id STRING(100) NOT NULL OPTIONS(description='Country iso code'),
campaign_group_id STRING(100) OPTIONS(description='Campaign group (only smp), clustering campaigns'),
campaign_group_name STRING(500) OPTIONS(description='Name of the campaign group'),
source_system_id STRING(100) NOT NULL OPTIONS(description='Sourcesystem, e.g. DWH, SMP, PIQ'),
create_tmsp DATETIME NOT NULL OPTIONS(description='Creation timestamp_ntz(9)'),
load_id INTEGER NOT NULL OPTIONS(description='Generated load id of the transformation job')
) OPTIONS(description='Campaign group masterdata from source system SMP');
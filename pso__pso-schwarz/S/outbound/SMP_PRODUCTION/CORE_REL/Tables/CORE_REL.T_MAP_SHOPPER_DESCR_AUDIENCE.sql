CREATE OR REPLACE TABLE smp_production_core_rel.t_map_shopper_descr_audience (
division_id STRING(100) NOT NULL OPTIONS(description='Division Lidl or Kaufland (LDL/KFL)'),
country_id STRING(100) NOT NULL OPTIONS(description='Country iso code'),
shopper_id STRING(100) NOT NULL OPTIONS(description='Reference to the shopper masterdata '),
descr_audience_id STRING(100) NOT NULL OPTIONS(description='Reference to the descriptive audience masterdata'),
source_system_id STRING(100) NOT NULL OPTIONS(description='Sourcesystem, e.g. DWH, SMP, PIQ'),
create_tmsp DATETIME NOT NULL OPTIONS(description='Creation timestamp_ntz(9)'),
load_id INTEGER NOT NULL OPTIONS(description='Generated load id of the transformation job')
) OPTIONS(description='Mapping between shopper and decriptive audience masterdata');
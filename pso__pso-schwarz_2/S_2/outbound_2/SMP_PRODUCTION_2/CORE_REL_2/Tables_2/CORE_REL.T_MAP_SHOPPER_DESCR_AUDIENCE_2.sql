CREATE OR REPLACE TABLE smp_production_core_rel.t_map_shopper_descr_audience_2 (
division_id STRING(100) NOT NULL OPTIONS(description='Division Lidl or Kaufland (LDL/KFL)'),
country_id STRING(100) NOT NULL OPTIONS(description='Country_2 iso code'),
shopper_id STRING(100) NOT NULL OPTIONS(description='Reference to the shopper_2 masterdata '),
descr_audience_id STRING(100) NOT NULL OPTIONS(description='Reference to the descriptive audience masterdata'),
source_system_id STRING(100) NOT NULL OPTIONS(description='Sourcesystem, e.g. DWH, SMP, PIQ'),
create_tmsp DATETIME NOT NULL OPTIONS(description='Creation timestamp_ntz(9)'),
load_id INTEGER NOT NULL OPTIONS(description='Generated load id of the transformation job')
) OPTIONS(description='Mapping between shopper_2 and decriptive audience masterdata');
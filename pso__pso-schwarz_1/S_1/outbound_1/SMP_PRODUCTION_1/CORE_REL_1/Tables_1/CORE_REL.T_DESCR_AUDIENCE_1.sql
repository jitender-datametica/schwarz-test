CREATE OR REPLACE TABLE smp_production_core_rel.t_descr_audience_1 (
division_id STRING(100) NOT NULL OPTIONS(description='Division Lidl or Kaufland (LDL/KFL)'),
country_id STRING(100) NOT NULL OPTIONS(description='Country_1 iso code'),
descr_audience_type_id STRING(100) NOT NULL OPTIONS(description='Reference to the descriptive audience type'),
descr_audience_id STRING(100) NOT NULL OPTIONS(description='ID of the descriptive audience, e.g. AGE00001'),
descr_audience_name STRING(16777216) NOT NULL OPTIONS(description='Description of the descriptive audience'),
descr_audience_value STRING(16777216) NOT NULL OPTIONS(description='Value of the descriptive audience'),
source_system_id STRING(100) NOT NULL OPTIONS(description='Sourcesystem, e.g. DWH, SMP, PIQ'),
create_tmsp DATETIME NOT NULL OPTIONS(description='Creation timestamp_ntz(9)'),
load_id INTEGER NOT NULL OPTIONS(description='Generated load id of the transformation job')
) OPTIONS(description='Decriptive audience masterdata, e.g. age 1-10 years, male, zipcode');
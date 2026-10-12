CREATE OR REPLACE TABLE smp_production_core_rel.t_descr_audience_type (
division_id STRING(100) NOT NULL OPTIONS(description='Division Lidl or Kaufland (LDL/KFL)'),
country_id STRING(100) NOT NULL OPTIONS(description='Country iso code'),
descr_audience_segment_id STRING(100) NOT NULL OPTIONS(description='Segment of the type, e.g. Demographic'),
descr_audience_type_id STRING(100) NOT NULL OPTIONS(description='Key of the type, eg. AGE, GENDER, ZIP'),
descr_audience_type_name STRING(16777216) NOT NULL OPTIONS(description='Description of the type'),
active_fg INTEGER NOT NULL OPTIONS(description='Flag for the Acitvity, indicates the usage for SMP Interface'),
source_system_id STRING(100) NOT NULL OPTIONS(description='Sourcesystem, e.g. DWH, SMP, PIQ'),
create_tmsp DATETIME NOT NULL OPTIONS(description='Creation timestamp_ntz(9)'),
load_id INTEGER NOT NULL OPTIONS(description='Generated load id of the transformation job')
) OPTIONS(description='Decriptive audience type masterdata, e.g. age, gender, zipcode');
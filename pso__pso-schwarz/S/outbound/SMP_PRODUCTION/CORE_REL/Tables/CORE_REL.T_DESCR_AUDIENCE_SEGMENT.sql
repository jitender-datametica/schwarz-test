CREATE OR REPLACE TABLE smp_production_core_rel.t_descr_audience_segment (
division_id STRING(100) NOT NULL OPTIONS(description='Division Lidl or Kaufland (LDL/KFL)'),
country_id STRING(100) NOT NULL OPTIONS(description='Country iso code'),
descr_audience_segment_id STRING(100) NOT NULL OPTIONS(description='Segment of the type, e.g. Demographic'),
descr_audience_segment_name STRING(16777216) NOT NULL OPTIONS(description='Description of the segment'),
source_system_id STRING(100) NOT NULL OPTIONS(description='Sourcesystem, e.g. DWH, SMP, PIQ'),
create_tmsp DATETIME NOT NULL OPTIONS(description='Creation timestamp_ntz(9)'),
load_id INTEGER NOT NULL OPTIONS(description='Generated load id of the transformation job')
) OPTIONS(description='Decriptive audience segment masterdata, e.g. Demographic');
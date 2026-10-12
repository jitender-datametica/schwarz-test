CREATE OR REPLACE TABLE szd_production_etl.t_cache_svtext_1 (
source_system STRING(2000),
extraction_date DATE,
load_id NUMERIC(29,5),
entitaetsid INTEGER,
sprid INTEGER,
textnr NUMERIC(29,5),
bezeichnung STRING(2000),
freitext STRING(2000),
aenddatum TIMESTAMP,
aendbenid INTEGER,
dwh_created_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(2000),
dwh_src_1_tmsp TIMESTAMP
);
CREATE OR REPLACE TABLE szd_production_etl.t_cache_ssland_2 (
source_system STRING(2000),
extraction_date DATE,
load_id NUMERIC(29,5),
landid INTEGER,
sprid INTEGER,
bez STRING(2000),
wirtschraumid INTEGER,
statlandcode STRING(2000),
ustidlandcode STRING(2000),
ustidbezlandspr STRING(2000),
lieferschwelleeuro NUMERIC(29,5),
hermeslandid INTEGER,
landposttext STRING(2000),
wrgid INTEGER,
checkli STRING(2000),
aenddatum DATE,
aendbenid INTEGER,
landkz STRING(2000),
zielland STRING(2000),
kaufland STRING(2000),
dwh_created_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(2000),
dwh_src_1_tmsp TIMESTAMP
);
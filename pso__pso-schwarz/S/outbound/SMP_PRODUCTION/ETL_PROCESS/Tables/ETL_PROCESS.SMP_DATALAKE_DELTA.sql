CREATE OR REPLACE TABLE smp_production_etl_process.smp_datalake_delta (
interface STRING(200),
load_tmsp DATETIME,
version_start INTEGER,
version_end INTEGER,
cnt INTEGER,
load_id INTEGER,
transform_tmsp DATETIME
);
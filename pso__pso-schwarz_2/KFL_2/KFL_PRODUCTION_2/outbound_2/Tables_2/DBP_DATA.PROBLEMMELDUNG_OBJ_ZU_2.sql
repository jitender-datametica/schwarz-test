CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.problemmeldung_obj_zu_2 (
system_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
problemmeldung_id STRING(50) NOT NULL,
zus_obj_id STRING(30) NOT NULL,
wert_dec NUMERIC(18,3),
wert_date DATE,
wert_char STRING(100),
td_insert TIMESTAMP,
td_update TIMESTAMP
);
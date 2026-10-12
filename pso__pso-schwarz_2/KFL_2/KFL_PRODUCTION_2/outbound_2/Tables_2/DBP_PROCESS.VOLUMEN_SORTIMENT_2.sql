CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.volumen_sortiment_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
sortiment_kz BIGNUMERIC(38,0) NOT NULL,
vol_wert NUMERIC(9,3) NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);
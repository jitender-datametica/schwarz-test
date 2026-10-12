CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ts_kmr_freigabe_kjmo_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
kjmo BIGNUMERIC(38,0) NOT NULL,
freigabe_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);
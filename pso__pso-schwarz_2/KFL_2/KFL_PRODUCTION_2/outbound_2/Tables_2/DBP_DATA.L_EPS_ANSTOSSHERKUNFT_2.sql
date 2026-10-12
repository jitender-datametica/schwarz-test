CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_eps_anstossherkunft_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
anstossherkunft_kz STRING(2) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);
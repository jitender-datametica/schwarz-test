CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.mcx_zeitspanne_spr_zu_1 (
zeitspanne_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
zeitspanne_bez STRING(150) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);
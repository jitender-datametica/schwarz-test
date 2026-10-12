CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.mcx_bereich_spr_zu (
ber_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
ber_bez STRING(50) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);
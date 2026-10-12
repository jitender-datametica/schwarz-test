CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.phasenart_spr_zu_2 (
phasenart_id STRING(20) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
cpr_phase_bez STRING(40) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);
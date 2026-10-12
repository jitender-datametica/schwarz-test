CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.it_projekt_status_spr_zu (
it_projekt_status_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
it_projekt_status_bez STRING(30) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);
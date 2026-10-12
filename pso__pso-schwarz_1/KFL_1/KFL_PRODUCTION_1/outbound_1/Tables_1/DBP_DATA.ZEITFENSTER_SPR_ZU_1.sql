CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.zeitfenster_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
zeitfenster_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
zeitfenster_bez STRING(80) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);
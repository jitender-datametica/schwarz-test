CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.rueck_grund_spr_zu_1 (
rueck_grund_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
rueck_grund_bez STRING(30) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);
CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.lis_rekl_grund_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
lis_rekl_grund_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
lis_rekl_grund_bez STRING(40) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);
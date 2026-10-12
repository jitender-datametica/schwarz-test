CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.produktgruppe_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
produktgruppe_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
produktgruppe_bez STRING(40) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);
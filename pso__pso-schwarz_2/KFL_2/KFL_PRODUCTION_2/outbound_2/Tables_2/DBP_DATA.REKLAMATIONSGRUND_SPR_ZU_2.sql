CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.reklamationsgrund_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
reklamationsgrund_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
reklamationsgrund_bez STRING(40) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);
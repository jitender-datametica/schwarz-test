CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wup_typ_1 (
wup_typ_id BIGNUMERIC(38,0) NOT NULL,
wup_typ_bez STRING(40) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);
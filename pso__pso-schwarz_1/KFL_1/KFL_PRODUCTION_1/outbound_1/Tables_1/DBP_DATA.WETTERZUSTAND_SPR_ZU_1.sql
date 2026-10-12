CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wetterzustand_spr_zu_1 (
wetterzustand_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
wetterzustand_bez STRING(50) COLLATE 'und:ci' DEFAULT ' ' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);
CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.mdl_zeitspanne_einkauf_spr_zu (
zeitspanne_einkauf_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
zeitspanne_einkauf_bez STRING(80) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);
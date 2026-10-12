CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_buergschaft_typ (
buergschaft_typ_id BIGNUMERIC(38,0) NOT NULL,
buergschaft_typ_bez STRING(50) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);
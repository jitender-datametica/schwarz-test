CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_ofentyp (
mandant_id BIGNUMERIC(38,0) NOT NULL,
ofen_typ_id STRING(2) COLLATE 'und:ci' NOT NULL,
anz_backblech BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);
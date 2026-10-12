CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_lagertyp_1 (
lagernummer_id STRING(4) COLLATE 'und:ci' NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
lagertyp_id STRING(4) COLLATE 'und:ci' NOT NULL,
lagerzone_id STRING(1) COLLATE 'und:ci',
lagertyp_typ_id STRING(1) COLLATE 'und:ci' DEFAULT ' ' NOT NULL,
griffzone_typ_id STRING(1) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP,
lagersortiment_id STRING(1) COLLATE 'und:ci' DEFAULT '-' NOT NULL
);
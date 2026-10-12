CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_cd_typ_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
cd_typ_id STRING(2) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);
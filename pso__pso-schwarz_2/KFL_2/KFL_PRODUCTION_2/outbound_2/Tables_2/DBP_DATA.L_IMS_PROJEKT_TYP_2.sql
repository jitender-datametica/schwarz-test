CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_ims_projekt_typ_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
ims_projekt_typ_id STRING(1) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);
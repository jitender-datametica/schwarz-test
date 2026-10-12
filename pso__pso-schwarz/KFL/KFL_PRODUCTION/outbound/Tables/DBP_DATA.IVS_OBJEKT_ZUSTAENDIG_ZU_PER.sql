CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ivs_objekt_zustaendig_zu_per (
mandant_id BIGNUMERIC(38,0) NOT NULL,
immo_objekt_id STRING(20) COLLATE 'und:ci' NOT NULL,
zustaendig_typ_id BIGNUMERIC(38,0) NOT NULL,
dat_von DATE NOT NULL,
zustaendig_id BIGNUMERIC(38,0) NOT NULL,
dat_bis DATE NOT NULL,
kostenstelle_id STRING(20) COLLATE 'und:ci',
buchungskreis_id BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);
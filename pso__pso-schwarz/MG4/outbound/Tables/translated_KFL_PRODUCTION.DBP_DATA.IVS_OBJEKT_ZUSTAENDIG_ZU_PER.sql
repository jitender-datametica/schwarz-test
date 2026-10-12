CREATE OR REPLACE TABLE kfl_production_dbp_data.ivs_objekt_zustaendig_zu_per (
mandant_id INTEGER NOT NULL,
immo_objekt_id STRING(20) COLLATE 'und:ci' NOT NULL,
zustaendig_typ_id INTEGER NOT NULL,
dat_von DATE NOT NULL,
zustaendig_id INTEGER NOT NULL,
dat_bis DATE NOT NULL,
kostenstelle_id STRING(20) COLLATE 'und:ci',
buchungskreis_id INTEGER,
td_insert TIMESTAMP,
td_update TIMESTAMP
);
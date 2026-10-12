CREATE OR REPLACE TABLE kfl_production_dbp_data.vz_wg_wup_zu_per (
mandant_id INTEGER NOT NULL,
arthiertyp_id INTEGER NOT NULL,
wg_hierarchie_ebene_id INTEGER NOT NULL,
wg_hierarchie_id INTEGER NOT NULL,
wup_id INTEGER NOT NULL,
nb_id INTEGER NOT NULL,
vz_wup_id INTEGER NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
vz_prio_id INTEGER,
kreistyp_id STRING(1) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);
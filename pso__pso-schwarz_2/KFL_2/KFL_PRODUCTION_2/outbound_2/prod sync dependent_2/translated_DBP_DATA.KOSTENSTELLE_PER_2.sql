CREATE OR REPLACE TABLE kfl_production_dbp_data.kostenstelle_per_2 (
mandant_id INTEGER NOT NULL,
system_id INTEGER NOT NULL,
kostenstelle_id STRING(10) COLLATE 'und:ci' NOT NULL,
dat_von DATE NOT NULL,
krk_id STRING(4) COLLATE 'und:ci' NOT NULL,
kostenstelle_bez STRING(30) COLLATE 'und:ci',
dat_bis DATE NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);
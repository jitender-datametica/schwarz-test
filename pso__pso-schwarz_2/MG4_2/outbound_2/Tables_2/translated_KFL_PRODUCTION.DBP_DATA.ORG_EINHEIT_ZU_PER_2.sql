CREATE OR REPLACE TABLE kfl_production_dbp_data.org_einheit_zu_per_2 (
hr_objekt_id_zu STRING(10) COLLATE 'und:ci' NOT NULL,
richtung_kz STRING(1) COLLATE 'und:ci' NOT NULL,
relat STRING(3) COLLATE 'und:ci' NOT NULL,
kjmo INTEGER NOT NULL,
mandant_id INTEGER NOT NULL,
hr_objekt_id INTEGER NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
system_id INTEGER NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);
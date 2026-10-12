CREATE OR REPLACE TABLE kfl_production_dbp_etl.org_einheit_zu_per_temp_1 (
hr_objekt_id_zu STRING(10) COLLATE 'und:ci',
richtung_kz STRING(1) COLLATE 'und:ci',
relat STRING(3) COLLATE 'und:ci',
kjmo INTEGER,
mandant_id INTEGER,
hr_objekt_id INTEGER,
dat_von DATE,
dat_bis DATE,
system_id INTEGER,
td_insert TIMESTAMP,
td_update TIMESTAMP,
update_mode STRING(255)
);
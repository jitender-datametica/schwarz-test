CREATE OR REPLACE TABLE kfl_production_dbp_etl.org_einheit_kst_tmp_1 (
mandant_id INTEGER NOT NULL,
hr_objekt_id INTEGER,
hr_objekt_id_zu STRING(10),
richtung_kz STRING(1) COLLATE 'und:ci',
relat STRING(3) COLLATE 'und:ci',
dat_von DATE,
dat_bis DATE,
system_id INTEGER NOT NULL,
kjmo INTEGER,
ranking INTEGER
);
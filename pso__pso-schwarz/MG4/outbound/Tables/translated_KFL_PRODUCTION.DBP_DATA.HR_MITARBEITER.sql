CREATE OR REPLACE TABLE kfl_production_dbp_data.hr_mitarbeiter (
mandant_id INTEGER NOT NULL,
mitarbeiter_id STRING(20) NOT NULL,
dat_geburtstag DATE NOT NULL,
land_id STRING(2) COLLATE 'und:ci' DEFAULT '  ' NOT NULL,
dat_uebernahme_azubi DATE,
td_insert TIMESTAMP,
td_update TIMESTAMP
);
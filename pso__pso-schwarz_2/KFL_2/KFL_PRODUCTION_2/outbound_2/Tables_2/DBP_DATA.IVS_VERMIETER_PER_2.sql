CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ivs_vermieter_per_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
vermieter_id BIGNUMERIC(38,0) NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
vermieter_branche_id STRING(3) COLLATE 'und:ci',
vermieter_rechtsform STRING(10) COLLATE 'und:ci',
vermieter_name STRING(80) COLLATE 'und:ci',
vermieter_strasse STRING(40) COLLATE 'und:ci',
vermieter_plz STRING(6) COLLATE 'und:ci',
vermieter_ort STRING(40) COLLATE 'und:ci',
dat_insolvenz_eintritt DATE,
intern_fg STRING(1) COLLATE 'und:ci',
land_id STRING(2) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);
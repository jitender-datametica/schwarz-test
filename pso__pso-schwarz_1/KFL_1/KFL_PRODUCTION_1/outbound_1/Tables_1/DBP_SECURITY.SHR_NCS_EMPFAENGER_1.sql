CREATE TABLE IF NOT EXISTS kfl_production_dbp_security.shr_ncs_empfaenger_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
kjmo BIGNUMERIC(38,0) NOT NULL,
hr_objekt_ebene1_id INTEGER NOT NULL,
email STRING(100) COLLATE 'und:ci' NOT NULL,
vorname STRING(100) COLLATE 'und:ci' NOT NULL,
nachname STRING(100) COLLATE 'und:ci' NOT NULL,
geschlecht_id BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
) CLUSTER BY kjmo;
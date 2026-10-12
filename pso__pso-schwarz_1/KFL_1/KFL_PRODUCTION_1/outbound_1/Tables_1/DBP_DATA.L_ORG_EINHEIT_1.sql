CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_org_einheit_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
hr_objekt_id INTEGER NOT NULL,
objekt_typ_id STRING(2) COLLATE 'und:ci' NOT NULL,
hr_objekt_bez_kurz STRING(10) COLLATE 'und:ci' NOT NULL,
ki_fg BIGNUMERIC(38,0) NOT NULL,
hr_objekt_bereich_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);
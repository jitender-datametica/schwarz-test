CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.it_projekt_bew (
it_projekt_id STRING(10) COLLATE 'und:ci' NOT NULL,
extern_fg BIGNUMERIC(38,0) NOT NULL,
dat_leistung DATE NOT NULL,
it_projekt_bereich_id STRING(10) COLLATE 'und:ci' DEFAULT '          ' NOT NULL,
it_plan_ebene_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
hr_objekt_ebene11_id INTEGER DEFAULT - 1 NOT NULL,
stunden_ist NUMERIC(18,3) NOT NULL,
stunden_bewertet NUMERIC(18,2) NOT NULL,
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);
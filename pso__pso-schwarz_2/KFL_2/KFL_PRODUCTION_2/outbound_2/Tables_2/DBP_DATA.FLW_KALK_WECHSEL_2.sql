CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_kalk_wechsel_2 (
auftrag_id STRING(20) COLLATE 'und:ci' NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
dat_kalk DATE NOT NULL,
trennprozess_id STRING(4) COLLATE 'und:ci' NOT NULL,
wechsel_id INTEGER NOT NULL,
werk_id BIGNUMERIC(38,0) NOT NULL,
system_id BIGNUMERIC(38,0),
flw_lief_id BIGNUMERIC(38,0) NOT NULL,
materialwert_kalk_id INTEGER NOT NULL,
tiergattung_id BIGNUMERIC(38,0) NOT NULL,
schnittliste_id INTEGER NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);
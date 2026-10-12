CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.load_teilprojekt_thema_1 (
teilprojekt_thema_id BIGNUMERIC(38,0) NOT NULL,
teilprojekt_id BIGNUMERIC(38,0) NOT NULL,
teilprojekt_thema_name STRING(50) COLLATE 'und:ci' NOT NULL,
dat_beginn DATE,
dat_ende DATE,
prio_kz BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);
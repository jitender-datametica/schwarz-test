CREATE TABLE IF NOT EXISTS kfl_production_dbp_ods.scans_pro_minute_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
kassierer_nr STRING(4) COLLATE 'und:ci' NOT NULL,
kjwo BIGNUMERIC(38,0) NOT NULL,
dat DATE NOT NULL,
anz_artikel BIGNUMERIC(38,0) NOT NULL,
registrierzeit BIGNUMERIC(38,0) NOT NULL,
scans_pro_minute_2 NUMERIC(15,4),
gew_durchschnitt NUMERIC(18,4),
td_insert TIMESTAMP,
td_update TIMESTAMP
);
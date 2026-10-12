CREATE TABLE IF NOT EXISTS kfl_production_dbp_ods.ods_letzter_abverkauf (
kl_art_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
datzeit DATETIME NOT NULL,
dat DATE,
td_insert TIMESTAMP,
td_update TIMESTAMP
) CLUSTER BY mandant_id, dat
OPTIONS(description='ODS - Zeitpunkt des letzten Abverkaufs pro Artikel, Tag und Markt nur für die letzten 7 Tage');
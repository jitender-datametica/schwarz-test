CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_kalk_erzeugnis_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
kalk_id INTEGER NOT NULL,
kalkulationsart_id STRING(2) COLLATE 'und:ci' NOT NULL,
bewertung_variante_id STRING(3) COLLATE 'und:ci' NOT NULL,
kalk_version_id BIGNUMERIC(38,0) NOT NULL,
dat_kalk DATE NOT NULL,
dat_kalk_ab DATE NOT NULL,
dat_kalk_bis DATE NOT NULL,
kalk_variante_id STRING(4) COLLATE 'und:ci' DEFAULT '-1  ' NOT NULL,
flw_art_id BIGNUMERIC(38,0) NOT NULL,
werk_id BIGNUMERIC(38,0) NOT NULL,
system_id BIGNUMERIC(38,0) NOT NULL,
misch_kalk_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
losgroesse NUMERIC(18,3) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);
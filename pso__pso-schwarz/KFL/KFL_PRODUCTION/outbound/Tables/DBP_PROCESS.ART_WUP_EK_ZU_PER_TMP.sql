CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.art_wup_ek_zu_per_tmp (
art_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
ek_netto NUMERIC(18,4),
ek_netto_bnk NUMERIC(18,4),
ek_mep NUMERIC(18,4),
einstandspreis NUMERIC(18,4),
komponentenmenge NUMERIC(9,4) NOT NULL,
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL,
ek_nettonetto NUMERIC(18,4),
kein_zekp_fg BIGNUMERIC(38,0),
td_update TIMESTAMP,
td_insert TIMESTAMP
);
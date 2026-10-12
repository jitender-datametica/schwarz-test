CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.mk_zeroverkauf_2 (
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
art_id BIGNUMERIC(38,0) NOT NULL,
dat DATE NOT NULL,
zeitfenster_id BIGNUMERIC(38,0) NOT NULL,
aktion_fg BIGNUMERIC(38,0) NOT NULL,
art_fehlgrund_id BIGNUMERIC(38,0),
menge_lgbest NUMERIC(18,3) NOT NULL,
datzeit_letzter_abverkauf DATETIME,
art_fehlgrund_text STRING(500) COLLATE 'und:ci',
dat_erfasst DATETIME,
melde_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);
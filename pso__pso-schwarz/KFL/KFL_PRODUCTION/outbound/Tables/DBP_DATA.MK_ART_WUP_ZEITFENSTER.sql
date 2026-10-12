CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.mk_art_wup_zeitfenster (
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
art_id BIGNUMERIC(38,0) NOT NULL,
wtag_id BIGNUMERIC(38,0) NOT NULL,
zeitfenster_id BIGNUMERIC(38,0) NOT NULL,
aktion_fg BIGNUMERIC(38,0) NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
avg_menge NUMERIC(18,3) NOT NULL,
anz_tage_in_aktion BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);
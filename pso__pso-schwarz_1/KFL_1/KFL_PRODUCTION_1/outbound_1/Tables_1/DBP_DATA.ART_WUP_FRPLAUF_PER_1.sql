CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_wup_frplauf_per_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
art_id BIGNUMERIC(38,0) NOT NULL,
dat_von DATE DEFAULT CAST('1900-01-01' AS DATE) NOT NULL,
dat_bis DATE DEFAULT CAST('9999-12-31' AS DATE),
standardabweichung NUMERIC(10,5),
klassifikationsmittelwert NUMERIC(19,6),
servicelevel NUMERIC(5,2),
mindestbestand NUMERIC(19,6),
bestand NUMERIC(19,6),
frp_mindestbestand NUMERIC(19,6),
zielbestand NUMERIC(19,6),
maximalbestand NUMERIC(19,6),
td_insert TIMESTAMP,
td_update TIMESTAMP
);
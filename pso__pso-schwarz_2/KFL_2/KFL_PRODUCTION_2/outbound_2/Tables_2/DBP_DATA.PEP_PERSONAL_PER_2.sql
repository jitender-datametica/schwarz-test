CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.pep_personal_per_2 (
idpersonal BIGNUMERIC(38,0) NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
stunden_woche NUMERIC(9,2) NOT NULL,
stunden_monat NUMERIC(9,2) NOT NULL,
idmastatus BIGNUMERIC(38,0) NOT NULL,
idcompany BIGNUMERIC(38,0) NOT NULL,
idabteilungen BIGNUMERIC(38,0) NOT NULL,
pep_ma_funktion_id BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);
CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.fipo_bericht_1 (
fipo_bericht_id BIGNUMERIC(38,0) NOT NULL,
fipo_pruef_objekt_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
fipo_pruef_modul_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
dat_fipo_bericht DATE NOT NULL,
mobil_erfasst_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
nicht_auswerten_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
fipo_person_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
dat_bis DATE DEFAULT CAST('9999-12-31' AS DATE) NOT NULL,
zeit_fipo_bericht BIGNUMERIC(38,0) NOT NULL,
fipo_bericht_text STRING(5000) COLLATE 'und:ci' DEFAULT ' ' NOT NULL,
dat_versorgung DATE NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);
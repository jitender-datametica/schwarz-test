CREATE TABLE IF NOT EXISTS kfl_production_dbp_dialog.d_flaeche_aktivitaet (
flaeche_id STRING(50) COLLATE 'und:ci' NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
aktivitaet_typ_id BIGNUMERIC(38,0) NOT NULL,
dat_aktivitaet DATE NOT NULL,
aktivitaet_ergebnis STRING(1200) COLLATE 'und:ci'
);
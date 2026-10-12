CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.check_kunden_umsatz_1 (
dat DATE NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
kassierer_nr BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
kasse_nr BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
anz_bon_sap BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
umsatz_wrg STRING(3) COLLATE 'und:ci' NOT NULL,
umsatz_brutto_gesamt NUMERIC(18,4) DEFAULT 0 NOT NULL,
umsatz_netto_gesamt NUMERIC(18,4) DEFAULT 0 NOT NULL,
umsatz_brutto_kasse NUMERIC(18,4) DEFAULT 0 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);
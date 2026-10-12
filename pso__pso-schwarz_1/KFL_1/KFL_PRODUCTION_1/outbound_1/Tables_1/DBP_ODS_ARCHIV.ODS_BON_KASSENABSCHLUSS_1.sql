CREATE TABLE IF NOT EXISTS kfl_production_dbp_ods_archiv.ods_bon_kassenabschluss_1 (
bon_id STRING(100) NOT NULL,
bon_dat DATE NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
anz_kunden BIGNUMERIC(38,0) NOT NULL,
umsatz_brutto NUMERIC(18,4) DEFAULT 0 NOT NULL,
anz_kunden_imbiss BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);
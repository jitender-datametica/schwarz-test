CREATE TABLE IF NOT EXISTS kfl_production_dbp_ods_archiv.ods_bon_leergut_2 (
bon_id STRING(100) NOT NULL,
bon_zeile BIGNUMERIC(38,0) NOT NULL,
ean_kasse NUMERIC(26,0),
umsatz_brutto NUMERIC(18,4) DEFAULT 0 NOT NULL,
mandant_id BIGNUMERIC(38,0),
wup_id BIGNUMERIC(38,0),
start_bon_zeile TIMESTAMP,
bon_nr_extern BIGNUMERIC(38,0),
bon_dat DATE NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);
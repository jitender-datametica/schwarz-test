CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.posout_bon_abgleich_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
dat DATE NOT NULL,
posout_umsatz_brutto NUMERIC(18,4),
bon_umsatz_brutto NUMERIC(18,4),
dat_erfasst DATE NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);
CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.bf_bons_kpim_akt_kmo_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
dat DATE NOT NULL,
bons BIGNUMERIC(38,0) NOT NULL,
bon_zeilen BIGNUMERIC(38,0) NOT NULL,
bons_af BIGNUMERIC(38,0) NOT NULL,
bons_sa BIGNUMERIC(38,0) NOT NULL,
bons_akt BIGNUMERIC(38,0) NOT NULL,
ges_umsatz_af NUMERIC(18,2) NOT NULL,
ges_umsatz_sa NUMERIC(18,2) NOT NULL,
ges_umsatz_akt NUMERIC(18,2) NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);
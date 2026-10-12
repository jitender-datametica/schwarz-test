CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.double_entry_set_flags (
mandant_id BIGNUMERIC(38,0),
wup_id BIGNUMERIC(38,0),
bon_id STRING(100),
bon_dat DATE,
kl_art_id BIGNUMERIC(38,0),
bon_zeile BIGNUMERIC(38,0),
menge NUMERIC(18,3),
umsatz_brutto NUMERIC(18,4),
kpos_erfassung_id STRING(2040),
marker INTEGER
);
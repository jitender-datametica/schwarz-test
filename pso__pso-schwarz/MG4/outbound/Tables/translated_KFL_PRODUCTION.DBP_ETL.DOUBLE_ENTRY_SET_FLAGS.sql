CREATE OR REPLACE TABLE kfl_production_dbp_etl.double_entry_set_flags (
mandant_id INTEGER,
wup_id INTEGER,
bon_id STRING(100),
bon_dat DATE,
kl_art_id INTEGER,
bon_zeile INTEGER,
menge NUMERIC(18,3),
umsatz_brutto NUMERIC(18,4),
kpos_erfassung_id STRING(2040),
marker INTEGER
);
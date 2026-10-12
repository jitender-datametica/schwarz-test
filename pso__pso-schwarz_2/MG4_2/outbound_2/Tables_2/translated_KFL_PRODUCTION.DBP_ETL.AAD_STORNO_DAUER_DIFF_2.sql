CREATE OR REPLACE TABLE kfl_production_dbp_etl.aad_storno_dauer_diff_2 (
mandant_id INTEGER,
wup_id INTEGER,
bon_dat DATE,
bon_id STRING(100),
bon_nr INTEGER,
kasse_nr INTEGER,
bon_zeile INTEGER,
start_bon_zeile DATETIME,
kpos_erfassung_id STRING(2040),
wg_id INTEGER,
kl_art_id INTEGER,
ean_kasse INTEGER,
menge NUMERIC(18,3),
einh_id STRING(12),
umsatz_brutto NUMERIC(18,4),
stornodauer INTEGER
);
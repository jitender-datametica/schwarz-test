CREATE OR REPLACE TABLE kfl_production_dbp_etl.filter_for_stornozeit (
mandant_id INTEGER,
wup_id INTEGER,
bon_dat DATE,
bon_id STRING(100),
bon_nr INTEGER,
kasse_nr INTEGER,
bon_zeile INTEGER,
start_zeile TIME,
erfassungsart STRING(2040),
wg INTEGER,
kl_art_id INTEGER,
ean_kasse INTEGER,
menge NUMERIC(18,3),
gesamtpreis NUMERIC(18,4),
stornozeit INTEGER,
beschreibung STRING(12)
);
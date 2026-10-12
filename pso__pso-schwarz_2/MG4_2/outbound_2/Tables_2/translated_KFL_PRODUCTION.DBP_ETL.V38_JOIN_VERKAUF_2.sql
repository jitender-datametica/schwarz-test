CREATE OR REPLACE TABLE kfl_production_dbp_etl.v38_join_verkauf_2 (
bon_id STRING(100),
bon_nr INTEGER,
wup_id INTEGER,
bon_dat DATE,
mandant_id INTEGER,
kassierer_nr STRING(4),
kasse_nr INTEGER,
wrg_id STRING(3),
bon_booking DATETIME,
umsatz_brutto NUMERIC(29,4),
kl_art_id INTEGER,
retoure_cnt NUMERIC(29,3)
);
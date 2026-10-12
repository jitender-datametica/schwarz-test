DROP TABLE IF EXISTS kfl_production_dbp_data_center.wasa_artbew_woche_1;
CREATE OR REPLACE TABLE kfl_production_dbp_data_center.wasa_artbew_woche_1 (
mandant_id INTEGER,
kl_art_id INTEGER,
wup_id INTEGER,
kjwo INTEGER,
umsatz_netto NUMERIC(29,4),
absatz NUMERIC(29,3)
) CLUSTER BY mandant_id, kjwo;
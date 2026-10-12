CREATE OR REPLACE TABLE kfl_production_dbp_data.gp_ums_ek_2 (
mandant_id INTEGER NOT NULL,
gp_id INTEGER NOT NULL,
einkaufsorganisation_id INTEGER,
kj_bezugsjahr INTEGER,
teilgebiet STRING(10) COLLATE 'und:ci',
umsatz_netto NUMERIC(12,2),
umsatz_wrg_id STRING(3) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);
CREATE OR REPLACE TABLE kfl_production_dbp_etl.sort_ist_1 (
wup_id INTEGER,
kreistyp_gruppe_id STRING(1) COLLATE 'und:ci',
mandant_id INTEGER,
wg_id INTEGER,
art_id INTEGER,
kassenumsatz FLOAT64,
anz_tage INTEGER,
preis FLOAT64,
list_kz STRING(2) COLLATE 'und:ci'
);
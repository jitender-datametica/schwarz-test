CREATE OR REPLACE TABLE kfl_production_dbp_etl.st_listung_kw_kmo (
mandant_id INTEGER,
wg_id INTEGER,
art_id INTEGER,
wup_id INTEGER,
nb_id INTEGER,
kreistyp_gruppe_id STRING(16) COLLATE 'und:ci',
kjwo INTEGER,
absatz NUMERIC(29,3),
absatz_sa NUMERIC(29,3),
absatz_af NUMERIC(29,3),
anzahl_wochen_mit_absatz INTEGER,
anzahl_wochen_mit_absatz_sa INTEGER,
anzahl_wochen_mit_absatz_af INTEGER
);
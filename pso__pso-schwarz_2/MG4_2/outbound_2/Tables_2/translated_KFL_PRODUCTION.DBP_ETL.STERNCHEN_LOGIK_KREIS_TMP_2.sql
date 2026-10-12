CREATE OR REPLACE TABLE kfl_production_dbp_etl.sternchen_logik_kreis_tmp_2 (
mandant_id INTEGER NOT NULL,
art_id INTEGER NOT NULL,
kreistyp_gruppe_id STRING(4),
list_durchg_fg INTEGER,
bezugsweg1_fg INTEGER,
bezugsweg4_fg INTEGER,
kdis0_fg INTEGER,
kdis1_fg INTEGER,
anzahl_markt_soll INTEGER,
anzahl_markt_listung INTEGER,
anzahl_markt_bezugsweg1 INTEGER,
anzahl_markt_bezugsweg4 INTEGER,
anzahl_markt_kdis0 INTEGER,
anzahl_markt_kdis1 INTEGER
);
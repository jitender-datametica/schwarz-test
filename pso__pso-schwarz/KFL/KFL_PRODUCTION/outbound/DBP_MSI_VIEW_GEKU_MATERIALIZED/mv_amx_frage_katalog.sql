CREATE OR REPLACE TABLE dbp_msi_view_geku_materialized.mv_amx_frage_katalog (
amx_frage_katalog_id INTEGER,
amx_system_id INTEGER,
kmr_quelle_id INTEGER,
hauptbereich_id INTEGER,
teilbereich_id INTEGER,
frage_nr STRING(30) COLLATE 'und:ci',
int_frage_id STRING(30) COLLATE 'und:ci',
amx_frage_bez STRING(500) COLLATE 'und:ci',
amx_handlung_typ_id INTEGER
);
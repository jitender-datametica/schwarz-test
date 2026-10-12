CREATE OR REPLACE TABLE dbp_msi_view_geku_materialized.mv_amx_frage (
amx_frage_id INTEGER,
amx_system_id INTEGER,
pruef_kapitel_id INTEGER,
antwort_wert INTEGER,
amx_frage_katalog_id INTEGER,
kmr_quelle_id INTEGER,
anmerkung STRING(255) COLLATE 'und:ci',
eingabe STRING(255) COLLATE 'und:ci',
anz_fehler_amx INTEGER,
stichprobe_umfang INTEGER
);
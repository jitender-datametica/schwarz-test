CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_ios_materialized.mv_ginfo_flaeche_per_2 (
mandant_id INTEGER,
techn_platz_id STRING(30) COLLATE 'und:ci',
ginfo_flaeche_id STRING(50) COLLATE 'und:ci',
kjmo INTEGER,
ginfo_flaeche_netto NUMERIC(29,2),
ginfo_flaeche_brutto NUMERIC(29,2),
ginfo_achse_wert NUMERIC(29,3),
ginfo_achse_typ_id STRING(10) COLLATE 'und:ci',
ginfo_flaeche_typ_id STRING(50) COLLATE 'und:ci'
);
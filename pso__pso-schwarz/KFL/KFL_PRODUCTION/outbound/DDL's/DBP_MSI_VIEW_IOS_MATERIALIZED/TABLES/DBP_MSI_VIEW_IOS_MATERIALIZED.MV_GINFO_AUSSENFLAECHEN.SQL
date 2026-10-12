CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_ios_materialized.mv_ginfo_aussenflaechen (
techn_platz_id STRING(30) COLLATE 'und:ci',
grp_1_id INTEGER,
grp_2_id INTEGER,
grp_3_id INTEGER,
grp_4_id INTEGER,
kaufland_typ_id STRING(20) COLLATE 'und:ci',
flaeche_attribut_id INTEGER,
quelle_beauftragung INTEGER,
ginfo_flaeche_brutto NUMERIC(29,2)
);
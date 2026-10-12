CREATE OR REPLACE TABLE dbp_msi_view_geku_materialized.mv_amx_l_pruef_objekt (
business_unit_id INTEGER,
amx_system_id INTEGER,
business_unit_bez STRING(255) COLLATE 'und:ci',
pruef_feld_typ_id INTEGER,
mandant_id INTEGER,
in_matrix_pruefgebiete_fg INTEGER,
aktiv_fg INTEGER
);
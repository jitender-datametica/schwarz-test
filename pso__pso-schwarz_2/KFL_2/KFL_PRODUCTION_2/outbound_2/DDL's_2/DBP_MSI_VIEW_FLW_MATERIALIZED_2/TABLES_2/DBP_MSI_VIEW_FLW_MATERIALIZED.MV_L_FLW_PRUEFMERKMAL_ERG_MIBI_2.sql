CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_flw_materialized.mv_l_flw_pruefmerkmal_erg_mibi_2 (
prueflos_id INTEGER,
mandant_id INTEGER,
satzstatus_id INTEGER,
gkz_fehlerklasse_id INTEGER,
entero_fehlerklasse_id INTEGER,
gkz_katalogart_id STRING(16777216) COLLATE 'und:ci',
entero_katalogart_id STRING(16777216) COLLATE 'und:ci',
gkz_codegruppe_id STRING(16777216) COLLATE 'und:ci',
entero_codegruppe_id STRING(16777216) COLLATE 'und:ci',
gkz_pruefcode_id STRING(16777216) COLLATE 'und:ci',
entero_pruefcode_id STRING(16777216) COLLATE 'und:ci',
we_dat DATE,
mibi_erfass_dat DATE,
gkz_original_input STRING(16777216) COLLATE 'und:ci',
entero_original_input STRING(16777216) COLLATE 'und:ci'
);
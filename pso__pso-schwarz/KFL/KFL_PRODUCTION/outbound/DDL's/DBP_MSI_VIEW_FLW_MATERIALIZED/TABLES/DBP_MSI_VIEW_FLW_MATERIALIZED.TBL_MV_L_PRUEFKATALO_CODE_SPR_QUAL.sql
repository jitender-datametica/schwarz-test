CREATE OR REPLACE TABLE dbp_msi_view_flw_materialized.tbl_mv_l_pruefkatalo_code_spr_qual (
mandant_id INTEGER,
katalogart_id STRING(1) COLLATE 'und:ci',
codegruppe_id STRING(10) COLLATE 'und:ci',
pruefcode_id STRING(4) COLLATE 'und:ci',
version_id INTEGER,
spr_id INTEGER,
pruefkatalog_code_bez STRING(40) COLLATE 'und:ci'
);
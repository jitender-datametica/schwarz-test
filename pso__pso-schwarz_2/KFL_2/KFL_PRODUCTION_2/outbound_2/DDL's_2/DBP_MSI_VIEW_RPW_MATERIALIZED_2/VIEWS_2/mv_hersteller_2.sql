CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_rpw_materialized.mv_hersteller_2 (
herst_id INTEGER,
herst_name STRING(40) COLLATE 'und:ci',
mandant_id INTEGER,
strasse STRING(40) COLLATE 'und:ci',
plz STRING(10) COLLATE 'und:ci',
ort STRING(40) COLLATE 'und:ci',
land_id STRING(2) COLLATE 'und:ci',
herst_fg INTEGER,
ampel_flg INTEGER,
system_id INTEGER
);
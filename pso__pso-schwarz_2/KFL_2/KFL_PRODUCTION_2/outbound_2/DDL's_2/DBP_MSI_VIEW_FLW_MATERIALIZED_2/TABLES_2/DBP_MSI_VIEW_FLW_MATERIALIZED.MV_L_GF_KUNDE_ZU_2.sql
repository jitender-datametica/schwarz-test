CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_flw_materialized.mv_l_gf_kunde_zu_2 (
vkl_id INTEGER,
gf_id INTEGER,
vkl_name STRING(320),
mandant_id INTEGER,
in_kunde_id INTEGER,
kunde_nr STRING(10) COLLATE 'und:ci',
kunde_name STRING(40) COLLATE 'und:ci'
);
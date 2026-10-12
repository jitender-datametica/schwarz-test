CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_flw_materialized.mv_f_flw_tqm_massentest_2 (
mandant_id INTEGER,
in_lief_id INTEGER,
in_art_id INTEGER,
dat_test DATE,
pc_id STRING(10) COLLATE 'und:ci',
krk_id STRING(4) COLLATE 'und:ci',
anz_stck_geprueft INTEGER,
anz_kf_fehler INTEGER,
anz_vk_fehler INTEGER
);
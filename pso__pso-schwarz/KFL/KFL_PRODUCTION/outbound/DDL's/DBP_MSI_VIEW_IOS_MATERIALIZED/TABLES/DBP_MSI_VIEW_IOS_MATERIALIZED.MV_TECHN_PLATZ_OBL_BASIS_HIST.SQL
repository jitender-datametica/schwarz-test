CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_ios_materialized.mv_techn_platz_obl_basis_hist (
techn_platz_id STRING(30) COLLATE 'und:ci',
projekt_id STRING(32) COLLATE 'und:ci',
mandant_id INTEGER,
tech_platz_bez STRING(40) COLLATE 'und:ci',
tp_vl_name STRING(40) COLLATE 'und:ci',
tp_vkl_name STRING(40) COLLATE 'und:ci',
tp_ol_vermietung STRING(40) COLLATE 'und:ci',
tp_bl_kbl_name STRING(40) COLLATE 'und:ci',
tp_betreuer_kbl_name STRING(40) COLLATE 'und:ci',
tp_betreuer_handy_nr STRING(20) COLLATE 'und:ci',
tp_betreuer_hls_name STRING(40) COLLATE 'und:ci',
tp_betreuer_elektro_name STRING(40) COLLATE 'und:ci',
tp_bl_projekt_name STRING(40) COLLATE 'und:ci',
tp_pl_kbl STRING(40) COLLATE 'und:ci',
dat_extrakt DATE
);
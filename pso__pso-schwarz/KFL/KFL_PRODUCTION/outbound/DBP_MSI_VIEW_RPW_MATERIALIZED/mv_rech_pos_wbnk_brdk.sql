CREATE OR REPLACE TABLE dbp_msi_view_rpw_materialized.mv_rech_pos_wbnk_brdk (
system_id INTEGER,
mandant_id INTEGER,
rech_beleg_id INTEGER,
gj INTEGER,
wbnk_planungs_kz STRING(19),
row_grund_id STRING(3) COLLATE 'und:ci'
);
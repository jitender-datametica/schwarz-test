CREATE OR REPLACE TABLE dbp_msi_view_flw_materialized.tbl_mv_f_kostenrechnung (
buchungskreis_id_ker STRING(6) COLLATE 'und:ci',
buchungsperiode_id INTEGER,
gj INTEGER,
kjmo INTEGER,
kostenart_id STRING(10) COLLATE 'und:ci',
krk_id STRING(4) COLLATE 'und:ci',
mandant_id INTEGER,
pc_id STRING(10) COLLATE 'und:ci',
plan_fg INTEGER,
planvariante_id STRING(4) COLLATE 'und:ci',
kostenrechnung_betrag_org NUMERIC(29,2),
wrg_id_orig STRING(3) COLLATE 'und:ci',
max_dat DATE,
default_wrg STRING(12) COLLATE 'und:ci'
);
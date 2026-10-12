DROP TABLE IF EXISTS kfl_production_dbp_msi_view_flw_materialized.tbl_mv_f_artbew_2;
CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_flw_materialized.tbl_mv_f_artbew_2 (
dat DATE,
mandant_id INTEGER,
art_id INTEGER,
in_kunde_id INTEGER,
kunde_nr STRING(10) COLLATE 'und:ci',
kunde_name STRING(40) COLLATE 'und:ci',
in_art_id INTEGER,
in_art_nr STRING(20) COLLATE 'und:ci',
vk_menge_org NUMERIC(29,3),
basismenge_einh_id STRING(3) COLLATE 'und:ci',
vk_menge_st NUMERIC(29,6),
vk_menge_kg NUMERIC(29,6),
ek_mep_umsatz_temp NUMERIC(29,4),
bewart_id INTEGER,
gp_id INTEGER,
default_wrg STRING(12) COLLATE 'und:ci',
wrg_2 STRING(3),
umsatz_netto NUMERIC(29,4)
) CLUSTER BY mandant_id;
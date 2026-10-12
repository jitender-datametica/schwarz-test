CREATE OR REPLACE TABLE dbp_msi_view_flw_materialized.tbl_mv_f_artbew_vw_sum_2 (
dat DATE,
mandant_id INTEGER,
art_id INTEGER,
vw_id INTEGER,
in_art_id INTEGER,
in_art_nr STRING(20) COLLATE 'und:ci',
vk_menge_org NUMERIC(29,3),
basismenge_einh_id STRING(3) COLLATE 'und:ci',
vk_menge_st NUMERIC(29,6),
vk_menge_kg NUMERIC(29,6),
ek_mep_umsatz_temp NUMERIC(29,4),
bewart_id INTEGER,
gp_id INTEGER,
wrg_id STRING(3) COLLATE 'und:ci',
default_wrg STRING(12) COLLATE 'und:ci',
umsatz_netto NUMERIC(29,4)
);
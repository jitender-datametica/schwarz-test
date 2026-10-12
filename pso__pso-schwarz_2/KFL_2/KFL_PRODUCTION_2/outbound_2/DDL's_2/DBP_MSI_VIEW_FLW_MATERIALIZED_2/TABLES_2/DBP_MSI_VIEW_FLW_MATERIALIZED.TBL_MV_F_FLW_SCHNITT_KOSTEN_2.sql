CREATE OR REPLACE TABLE dbp_msi_view_flw_materialized.tbl_mv_f_flw_schnitt_kosten_2 (
mandant_id INTEGER,
schnitt_id INTEGER,
sek_schl_typ_id STRING(1) COLLATE 'und:ci',
sek_schl_id INTEGER,
input_typ_id STRING(1) COLLATE 'und:ci',
kosten_block_id STRING(3) COLLATE 'und:ci',
default_wrg STRING(12) COLLATE 'und:ci',
fertig_einzel_kosten_kg NUMERIC(29,4),
wrg_id STRING(3) COLLATE 'und:ci',
dat_kalk_ab_v02 DATE,
dat_kalk_ab_v03 DATE
);
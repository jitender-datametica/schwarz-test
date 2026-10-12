CREATE OR REPLACE TABLE dbp_msi_view_flw_materialized.tbl_mv_f_kondit_det (
mandant_id INTEGER,
kondition_id INTEGER,
konditionsart_id STRING(4) COLLATE 'und:ci',
in_art_id INTEGER,
dat_bis DATE,
dat_von DATE,
dat DATE,
wrg_id_org STRING(3) COLLATE 'und:ci',
preisliste_typ_id STRING(2) COLLATE 'und:ci',
in_vw_id INTEGER,
art_id INTEGER,
default_wrg STRING(12) COLLATE 'und:ci',
betrag_kondition NUMERIC(29,4),
umrech_faktor BIGNUMERIC(38,14)
);
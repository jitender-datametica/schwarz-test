CREATE OR REPLACE TABLE dbp_msi_view_flw_materialized.tbl_mv_f_flw_kondit_det_notierung (
mandant_id INTEGER,
werk_id INTEGER,
flw_lief_id INTEGER,
flw_art_id INTEGER,
loesch_fg INTEGER,
konditionsart_id STRING(4) COLLATE 'und:ci',
dat_von DATE,
dat DATE,
kondition_id INTEGER,
default_wrg STRING(12) COLLATE 'und:ci',
kondition_einh_id STRING(3) COLLATE 'und:ci',
betrag_kondition NUMERIC(29,4),
fleisch_kategorie_id INTEGER,
kpi_kategorie_id INTEGER
);
CREATE OR REPLACE TABLE dbp_msi_view_flw_materialized.tbl_mv_f_flw_kondit_vorgang_1 (
mandant_id INTEGER,
beleg_kondition_id INTEGER,
beleg_kondition_pos_id INTEGER,
beleg_konditionsart_id STRING(4) COLLATE 'und:ci',
werk_id INTEGER,
loesch_id STRING(1) COLLATE 'und:ci',
best_beleg_pos_id INTEGER,
best_beleg_id INTEGER,
in_art_id INTEGER,
in_lief_id INTEGER,
wrg_id STRING(3) COLLATE 'und:ci',
dat_lief_wunsch DATE,
default_wrg STRING(12) COLLATE 'und:ci',
betrag_beleg_kondition NUMERIC(29,4)
);
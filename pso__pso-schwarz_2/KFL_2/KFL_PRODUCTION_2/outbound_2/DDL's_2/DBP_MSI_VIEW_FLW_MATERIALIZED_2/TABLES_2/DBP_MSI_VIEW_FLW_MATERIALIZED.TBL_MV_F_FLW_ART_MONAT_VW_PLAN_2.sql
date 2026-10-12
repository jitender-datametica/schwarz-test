CREATE OR REPLACE TABLE dbp_msi_view_flw_materialized.tbl_mv_f_flw_art_monat_vw_plan_2 (
mandant_id INTEGER,
in_art_id INTEGER,
werk_id INTEGER,
gjmo INTEGER,
in_vw_id INTEGER,
wa_betrag_org NUMERIC(29,3),
wa_menge_kg NUMERIC(29,3),
wa_menge_bme NUMERIC(29,4),
wrg_id_orig STRING(3) COLLATE 'und:ci',
default_wrg STRING(12) COLLATE 'und:ci',
wrg_id STRING(3) COLLATE 'und:ci',
max_dat DATE
);
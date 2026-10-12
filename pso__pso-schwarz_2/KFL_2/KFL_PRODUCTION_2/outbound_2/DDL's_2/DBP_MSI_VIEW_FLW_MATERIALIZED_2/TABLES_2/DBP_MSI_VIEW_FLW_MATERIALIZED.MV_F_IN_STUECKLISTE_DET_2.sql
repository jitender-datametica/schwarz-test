CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_flw_materialized.mv_f_in_stueckliste_det_2 (
mandant_id INTEGER,
in_art_id INTEGER,
stueckliste_typ_id STRING(1) COLLATE 'und:ci',
stueckliste_id INTEGER,
stueckliste_pos_id INTEGER,
loesch_fg INTEGER,
stueckliste_pos_typ_id STRING(1) COLLATE 'und:ci',
komponentenmenge NUMERIC(29,3),
komponentenmenge_einh_id STRING(3) COLLATE 'und:ci',
kalk_rlv_fg INTEGER
);
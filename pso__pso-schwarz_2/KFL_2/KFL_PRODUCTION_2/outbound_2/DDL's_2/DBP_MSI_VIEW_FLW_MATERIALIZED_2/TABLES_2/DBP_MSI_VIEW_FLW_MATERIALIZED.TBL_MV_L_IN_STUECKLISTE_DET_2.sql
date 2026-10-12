CREATE OR REPLACE TABLE dbp_msi_view_flw_materialized.tbl_mv_l_in_stueckliste_det_2 (
mandant_id INTEGER,
stueckliste_id INTEGER,
stueckliste_pos_id INTEGER,
stueckliste_typ_id STRING(1) COLLATE 'und:ci',
in_art_id INTEGER,
in_art_nr STRING(20) COLLATE 'und:ci',
art_bez STRING(40) COLLATE 'und:ci',
spr_id INTEGER
);
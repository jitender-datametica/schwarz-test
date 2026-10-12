CREATE OR REPLACE TABLE dbp_msi_view_flw_materialized.tbl_mv_l_flw_bew_output_1 (
mandant_id INTEGER,
bde_vorgang_id INTEGER,
werk_id INTEGER,
beleg_gruppe_id STRING(1) COLLATE 'und:ci',
in_art_id INTEGER,
in_art_nr STRING(20) COLLATE 'und:ci',
art_bez STRING(40) COLLATE 'und:ci',
flw_beleg_typ_id STRING(2) COLLATE 'und:ci',
status_mb STRING(1) COLLATE 'und:ci',
spr_id INTEGER
);
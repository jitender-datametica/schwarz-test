CREATE OR REPLACE TABLE dbp_msi_view_flw_materialized.tbl_mv_f_flw_kalk_preise_1 (
mandant_id INTEGER,
schnittliste_id INTEGER,
sek_schl_typ_id STRING(1) COLLATE 'und:ci',
sek_schl_id INTEGER,
in_art_id INTEGER,
input_material_typ_id STRING(1) COLLATE 'und:ci',
menge NUMERIC(29,3),
gesamt_wert NUMERIC(29,4),
menge_dme NUMERIC(29,3),
dme_einh_id STRING(3) COLLATE 'und:ci',
wrg_id STRING(3) COLLATE 'und:ci',
preis_kg NUMERIC(29,4),
default_wrg STRING(12) COLLATE 'und:ci',
dat_kalk_ab_v02 DATE,
dat_kalk_ab_v03 DATE
);
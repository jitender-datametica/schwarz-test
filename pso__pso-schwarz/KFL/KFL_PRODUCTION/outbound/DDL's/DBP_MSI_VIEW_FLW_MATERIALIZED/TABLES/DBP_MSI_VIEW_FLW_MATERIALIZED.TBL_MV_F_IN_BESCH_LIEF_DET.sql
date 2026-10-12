CREATE OR REPLACE TABLE dbp_msi_view_flw_materialized.tbl_mv_f_in_besch_lief_det (
lief_beleg_id INTEGER,
lief_beleg_pos_id INTEGER,
mandant_id INTEGER,
dat_lief_soll DATE,
in_verkaufsorganisation_id STRING(4) COLLATE 'und:ci',
werk_id INTEGER,
lief_pos_typ_id STRING(4) COLLATE 'und:ci',
in_art_id INTEGER,
charge_id STRING(10) COLLATE 'und:ci',
in_vw_id INTEGER,
dat_mat_bereitstllg DATE,
menge_lief_ist_bme NUMERIC(29,3),
verk_menge_einh_id STRING(3) COLLATE 'und:ci',
nettogew NUMERIC(29,3),
menge_lief_ist_lme NUMERIC(29,3),
vorlage_beleg_id INTEGER
);
DROP TABLE IF EXISTS dbp_msi_view_flw_materialized.tbl_mv_f_bestelldaten_2;
CREATE OR REPLACE TABLE dbp_msi_view_flw_materialized.tbl_mv_f_bestelldaten_2 (
mandant_id INTEGER,
lief_beleg_id INTEGER,
lief_typ_id STRING(4) COLLATE 'und:ci',
dat_lief_soll DATE,
lief_beleg_pos_id INTEGER,
werk_id INTEGER,
in_art_id INTEGER,
in_art_nr STRING(20) COLLATE 'und:ci',
basismenge_einh_id STRING(3) COLLATE 'und:ci',
verk_menge_einh_id STRING(3) COLLATE 'und:ci',
nettogew NUMERIC(29,3),
dat_mat_bereitstllg DATE,
dat_produktion DATE,
in_kunde_id INTEGER,
verkaufs_beleg_id INTEGER,
verkaufs_beleg_pos_id INTEGER,
menge_auftrag_vme_kum NUMERIC(29,3),
menge_bes_bme_kum NUMERIC(29,3),
menge_bes_bme_kum_kg NUMERIC(29,6)
) CLUSTER BY mandant_id, werk_id;
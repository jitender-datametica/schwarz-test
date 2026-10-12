DROP TABLE IF EXISTS kfl_production_dbp_msi_view_flw_materialized.mv_f_kunde_auftrag_det;
CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_flw_materialized.mv_f_kunde_auftrag_det (
mandant_id INTEGER,
verkaufs_beleg_id INTEGER,
verkaufs_beleg_pos_id INTEGER,
in_art_id INTEGER,
werk_id INTEGER,
in_vw_id INTEGER,
verk_menge_einh_id STRING(3) COLLATE 'und:ci',
menge_auftrag_vme_kum NUMERIC(29,3),
menge_bes_bme_kum NUMERIC(29,3),
menge_bes_bme_kum_kg NUMERIC(29,6),
absagegrund_id STRING(2) COLLATE 'und:ci',
best_beleg_id_kunde STRING(20) COLLATE 'und:ci',
auftragsart_id STRING(4) COLLATE 'und:ci',
in_verkaufsorganisation_id STRING(4) COLLATE 'und:ci',
in_art_id_kunde STRING(20) COLLATE 'und:ci',
wert_ek_netto NUMERIC(29,4),
zwsum_2_betrag NUMERIC(29,4),
zwsum_4_betrag BIGNUMERIC(38,10),
in_kunde_id INTEGER,
mandant_id_kunde INTEGER
) CLUSTER BY mandant_id, werk_id;
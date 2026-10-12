CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_l_flw_bew_output_1 (mandant_id, bde_vorgang_id,
werk_id, beleg_gruppe_id, in_art_id, in_art_nr, art_bez, flw_beleg_typ_id, status_mb) AS SELECT V01.mandant_id,
 V01.bde_vorgang_id,
 V01.werk_id,
 V01.beleg_gruppe_id,
 V01.in_art_id,
 V01.in_art_nr,
 V01.art_bez,
 V01.flw_beleg_typ_id,
 V01.status_mb
FROM kfl_production_dbp_msi_view_flw_materialized.tbl_mv_l_flw_bew_output_1 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu_1 AS V04 ON V01.spr_id = V04.spr_id;
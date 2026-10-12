CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_l_in_art_spr_zu_2 (mandant_id, in_art_id, spr_id,
art_bez) AS SELECT V01.mandant_id,
 V01.in_art_id,
 V01.spr_id,
 V01.art_bez
FROM kfl_production_dbp_msi_view_flw_materialized.tbl_mv_l_in_art_spr_zu_2 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu_2 AS V03 ON V01.spr_id = V03.spr_id;
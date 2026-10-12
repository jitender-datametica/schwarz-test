CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_prodh_lvl_6_spr_zu_1 (mandant_id, spr_id,
prodh_lvl_6, prodh_lvl_6_bez) AS SELECT V01.mandant_id,
 V01.spr_id,
 V01.art_col_auspr AS prodh_lvl_6,
 V01.art_col_bez AS prodh_lvl_6_bez
FROM kfl_production_dbp_view.v_flw_art_col_spr_zu_1 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu_1 AS V02 ON V01.spr_id = V02.spr_id
WHERE V01.flw_art_col_id = 6;
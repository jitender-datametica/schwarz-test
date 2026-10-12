CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_prodh_lvl_2_spr_zu (mandant_id, spr_id, prodh_lvl_2,
prodh_lvl_2_bez) AS SELECT V01.mandant_id,
 V01.spr_id,
 V01.art_col_auspr AS prodh_lvl_2,
 V01.art_col_bez AS prodh_lvl_2_bez
FROM kfl_production_dbp_view.v_flw_art_col_spr_zu AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu AS V02 ON V01.spr_id = V02.spr_id
WHERE V01.flw_art_col_id = 2;
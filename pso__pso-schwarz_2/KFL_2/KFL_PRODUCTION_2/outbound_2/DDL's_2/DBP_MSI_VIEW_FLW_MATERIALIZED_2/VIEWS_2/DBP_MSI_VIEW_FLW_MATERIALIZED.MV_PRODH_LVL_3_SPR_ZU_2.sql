CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_prodh_lvl_3_spr_zu_2 (mandant_id, spr_id,
prodh_lvl_3, prodh_lvl_3_bez) AS SELECT V01.mandant_id,
 V01.spr_id,
 V01.prodh_lvl_3,
 V01.prodh_lvl_3_bez
FROM kfl_production_dbp_msi_view_flw_materialized.tbl_mv_prodh_lvl_3_spr_zu_2 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu_2 AS V02 ON V01.spr_id = V02.spr_id;
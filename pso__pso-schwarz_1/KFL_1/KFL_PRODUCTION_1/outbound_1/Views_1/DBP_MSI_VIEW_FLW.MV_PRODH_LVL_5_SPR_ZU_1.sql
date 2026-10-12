CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_prodh_lvl_5_spr_zu_1 AS SELECT V01.mandant_id,
 V01.spr_id,
 V01.prodh_lvl_5,
 V01.prodh_lvl_5_bez
FROM kfl_production_dbp_msi_view_flw.tbl_mv_prodh_lvl_5_spr_zu_1 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu_1 AS V02 ON V01.spr_id = V02.spr_id;
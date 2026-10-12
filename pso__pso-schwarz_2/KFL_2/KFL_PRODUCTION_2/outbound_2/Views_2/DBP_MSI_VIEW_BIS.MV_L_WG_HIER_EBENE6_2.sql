CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_l_wg_hier_ebene6_2 AS SELECT in_wg_ebene6_id,
 in_wg_ebene5_id,
 in_wg_ebene4_id,
 in_wg_ebene3_id,
 in_wg_ebene2_id,
 in_wg_ebene1_id
FROM kfl_production_dbp_msi_view_bis.mv_wg_hier_denorm_2;
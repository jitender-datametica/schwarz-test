CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_monat_fwws_wup_gp_pc_1 AS SELECT mandant_id,
 nb_id,
 wup_id,
 gp_id,
 problemcode_id,
 kjmo,
 anz_fehler,
 anz_fehler_kum
FROM kfl_production_dbp_msi_v_view.v_vis_monat_gp_wup_probleme_1 AS V01;
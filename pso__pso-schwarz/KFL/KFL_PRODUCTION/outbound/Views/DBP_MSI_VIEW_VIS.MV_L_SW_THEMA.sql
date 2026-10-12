CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_l_sw_thema (sw_thema_id, sw_thema_bez) AS SELECT sw_thema_id,
 sw_thema_bez
FROM kfl_production_dbp_view.v_l_sw_thema;
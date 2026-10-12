CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_l_sw_attribut (sw_attribut_id, sw_attribut_bez) AS SELECT
 sw_attribut_id,
 sw_attribut_bez
FROM kfl_production_dbp_view.v_l_sw_attribut;
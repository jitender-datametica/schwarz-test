CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_l_waqfk_kennziffer (mandant_id, waqfk_fehler_id,
waqfk_kennziffer_id) AS SELECT mandant_id,
 waqfk_fehler_id,
 waqfk_kennziffer_id
FROM kfl_production_dbp_view.v_l_waqfk_kennziffer;
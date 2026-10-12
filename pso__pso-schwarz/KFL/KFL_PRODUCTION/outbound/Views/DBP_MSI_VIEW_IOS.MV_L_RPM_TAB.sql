CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_l_rpm_tab (rpm_tab_id, rpm_tab_bez) AS SELECT rpm_tab_id,
 rpm_tab_bez
FROM kfl_production_dbp_view.v_l_rpm_tab AS V01;
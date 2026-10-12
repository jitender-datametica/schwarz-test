CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_sec_dashboard_activation_2 (dashboard_name, dashboard_active_fg, load_id) AS
SELECT dashboard_name,
 dashboard_active_fg,
 load_id
FROM ldl_p_lew_mart_msi.t_msi_sec_dashboard_activation_2;
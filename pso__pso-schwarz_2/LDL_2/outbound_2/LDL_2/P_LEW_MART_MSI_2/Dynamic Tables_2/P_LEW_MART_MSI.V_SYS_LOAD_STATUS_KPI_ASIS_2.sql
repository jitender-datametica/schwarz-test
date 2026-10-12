CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_sys_load_status_kpi_asis_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT KPI.client_id,
 KPI.country_cd AS country_iso_cd,
 KPI.st_loc_sid AS store_id,
 WH.src_wh_id AS wh_id,
 KPI.dat_dayend,
 KPI.kpi_id,
 KPI.data_deliv_fg,
 KPI.kpi_avbl_fg,
 KPI.mod_tmsp
FROM ldl_p_lew_mart_msi.t_sys_load_status_kpi_asis_2 AS KPI
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_2 AS WH ON KPI.client_id = WH.client_id AND KPI.wh_loc_sid = WH.loc_sid_wh AND WH
   .dwh_actual_fg = 1;
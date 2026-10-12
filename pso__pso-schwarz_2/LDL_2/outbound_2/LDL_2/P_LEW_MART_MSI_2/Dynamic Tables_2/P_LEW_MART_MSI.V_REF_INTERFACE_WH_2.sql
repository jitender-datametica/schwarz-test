CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_ref_interface_wh_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT WHIN.client_id,
 WH.src_wh_id AS wh_id,
 WHIN.system_key,
 WHIN.system_desc,
 WHIN.interface_key,
 WHIN.interface_desc,
 WHIN.dat_rec_start,
 WHIN.dat_rec_end,
 WHIN.load_id
FROM ldl_p_lew_core_ac.v_wawi_ref_wh_interface_2 AS WHIN
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_2 AS WH ON WHIN.client_id = WH.client_id AND WHIN.wh_loc_sid = WH.loc_sid_wh AND
   WH.dwh_actual_fg = 1;
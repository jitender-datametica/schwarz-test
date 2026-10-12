CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_sys_interface_log
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT WLSP.client_id,
 COALESCE(WH.src_wh_id, WLSP.wh_loc_sid) AS wh_id,
 WLSP.wh_desc,
 WLSP.st_loc_sid AS store_id,
 WLSP.store_desc,
 WLSP.orig_store_nr,
 WLSP.system_key,
 WLSP.system_desc,
 WLSP.interface_key,
 WLSP.interface_desc,
 WLSP.dat_dayend,
 WLSP.mcc_fg,
 WLSP.mail_rows,
 WLSP.conv_rows,
 WLSP.load_rows,
 WLSP.mload_rows,
 WLSP.target_rows,
 WLSP.trans_fg,
 WLSP.timestamp_load,
 WLSP.timestamp_mod,
 WLSP.source_sent_tmsp,
 WLSP.mail_in_tmsp
FROM ldl_p_lew_core_ac.v_wawi_sys_load_status_present AS WLSP
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON WLSP.client_id = WH.client_id AND WLSP.wh_loc_sid = WH.loc_sid_wh AND
   WH.dwh_actual_fg = 1;
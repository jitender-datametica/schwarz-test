CREATE OR REPLACE TABLE ldl_p_lew_mart_msi.v_sys_interface_log_des_2 AS
-- Get all entries for transformations that belong to the last day of a busyear. This can be the 28th or the 29th of Feb. of the same year.

SELECT DISTINCT il.dc_load_id,
 il.dc_server_id,
 il.system_key,
 SSY.system_desc,
 il.interface_key,
 IFC.comment_string AS interface_desc,
 il.ctrcode,
 RCC.client_id,
 WH.src_wh_id AS wh_id,
 il.orig_store_nr,
 COALESCE(ST.loc_sid_store, 0) AS store_id,
 il.dat_dayend,
 il.dc_service_id,
 il.mail_rows,
 il.mail_bytes,
 il.conv_rows,
 il.conv_bytes,
 il.load_rows,
 NULL AS mload_rows,
 NULL AS target_rows,
  CASE
  WHEN TSSPEC.timestamp_end IS NOT NULL
  THEN 1
  WHEN TS.timestamp_end IS NULL
  THEN CASE
   WHEN tsx.dat_last_busyear_end IS NOT NULL AND il.system_key = 6 AND il.load_rows = tsx.l_0_cnt
   THEN 1
   ELSE 0
   END
  ELSE 1
  END AS trans_fg,
 il.timestamp_load,
 il.source_sent_tmsp,
 il.mail_in_tmsp
FROM (SELECT dc_load_id,
   dc_server_id,
   system_key,
   interface_key,
   ctrcode,
   wh_loc_sid,
   orig_store_nr,
   dat_dayend,
   dc_service_id,
   mail_rows,
   mail_bytes,
   conv_rows,
   conv_bytes,
   load_rows,
   timestamp_load,
   source_sent_tmsp,
   mail_in_tmsp
  FROM (SELECT dc_load_id,
      dc_server_id,
      system_key,
      interface_key,
      ctrcode,
      wh_loc_sid,
      orig_store_nr,
      dat_dayend,
      dc_service_id,
      mail_rows,
      mail_bytes,
      conv_rows,
      conv_bytes,
      load_rows,
      timestamp_load,
      source_sent_tmsp,
      mail_in_tmsp
     FROM ldl_p_lew_process_ac.v_wawi_sys_interface_log_base_2
     WHERE dat_dayend >= DATE_SUB(CURRENT_DATE, INTERVAL 2 DAY)
     UNION DISTINCT
     SELECT dc_load_id,
      dc_server_id,
      system_key,
      interface_key,
      ctrcode,
      wh_loc_sid,
      orig_store_nr,
      dat_dayend,
      dc_service_id,
      mail_rows,
      mail_bytes,
      conv_rows,
      conv_bytes,
      load_rows,
      timestamp_load,
      source_sent_tmsp,
      mail_in_tmsp
     FROM ldl_p_lew_process_ac.v_wawi_sys_interface_log_l_0_2) AS t2) AS il
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_2 AS WH ON il.wh_loc_sid = WH.loc_sid_wh AND WH.dwh_actual_fg = 1
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_interface_2 AS IFC ON il.system_key = IFC.system_key AND il.interface_key = IFC.interface_key
   
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_subsystem_2 AS SSY ON il.system_key = SSY.system_key
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_country_2 AS RC ON il.ctrcode = RC.country_iso_cd
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_country_2 AS RCC ON RC.country_id = RCC.country_id
 LEFT JOIN ldl_p_lew_bil_ac.v_store_2 AS ST ON RCC.client_id = ST.client_id AND ST.src_store_id = 0 AND ST.dwh_actual_fg =
   1
 LEFT JOIN ldl_p_lew_process_ac.v_wawi_sys_dc_trans_status_int_2 AS TS ON il.dc_server_id = TS.dc_server_id AND il.dc_load_id
        = TS.dc_load_id AND il.ctrcode = TS.country_iso_cd AND il.dat_dayend
     -- AND ZEROIFNULL(ts.wh_loc_sid) = ZEROIFNULL(il.wh_loc_sid)
 = TS.dat_dayend AND IFNULL(TS.wh_id, 0) = IFNULL(il.wh_loc_sid
     , 0) AND IFC.process_name = TS.interface_name
 LEFT JOIN ldl_p_lew_process_ac.v_wawi_sys_dc_trans_status_int_2 AS TSSPEC ON il.ctrcode = TSSPEC.country_iso_cd AND il.dat_dayend
      -- AND ZEROIFNULL(tsspec.wh_loc_sid) = ZEROIFNULL(il.wh_loc_sid)
 <= TSSPEC.dat_dayend AND IFNULL(TSSPEC.wh_id, 0
      ) = IFNULL(il.wh_loc_sid, 0) AND IFC.process_name = TSSPEC.interface_name AND TSSPEC.etl_type IN ('OVIS',
    'DISPO_MASTER')
 LEFT JOIN (SELECT TSI.dc_server_id,
   TSI.dc_load_id,
   TSI.country_iso_cd,
   -- tsi.wh_loc_sid,
 TSI.wh_id,
   TSI.interface_name,
   TSI.dat_dayend,
   TSI.l_0_cnt,
   cal2.dat_last_busyear_end
  FROM ldl_p_lew_process_ac.v_wawi_sys_dc_trans_status_int_2 AS TSI
   INNER JOIN ldl_p_lew_core_ac.v_wawi_cal_calendarday_2 AS CAL1 ON TSI.dat_dayend = CAL1.dat_calendar
   INNER JOIN (SELECT busyear,
     MAX(dat_calendar) AS dat_last_busyear_end
    FROM ldl_p_lew_core_ac.v_wawi_cal_calendarday_2
    GROUP BY busyear) AS cal2 ON CAL1.busyear = cal2.busyear
  WHERE TSI.dat_dayend = cal2.dat_last_busyear_end
   AND TSI.timestamp_end IS NOT NULL) AS tsx ON il.dc_server_id = tsx.dc_server_id AND il.dc_load_id = tsx.dc_load_id
     AND il.ctrcode = tsx.country_iso_cd -- AND il.wh_loc_sid    = tsx.wh_loc_sid
 AND il.wh_loc_sid = tsx.wh_id AND il
    .dat_dayend > tsx.dat_dayend AND IFC.process_name = tsx.interface_name
WHERE il.system_key NOT IN (2, 13);
CREATE OR REPLACE TABLE ldl_p_lew_mart_msi.v_sys_interface_log_kasse AS
SELECT il.dc_load_id,
 il.dc_server_id,
 il.system_key,
 SSY.system_desc,
 il.interface_key,
 IFC.comment_string AS interface_desc,
 il.ctrcode,
 RCC.client_id,
 WH.src_wh_id AS wh_id,
 il.orig_store_nr,
 COALESCE(STY.st_loc_sid, ST.loc_sid_store) AS store_id,
 il.dat_dayend,
 il.dc_service_id,
 il.mail_rows,
 il.mail_bytes,
 il.conv_rows,
 il.conv_bytes,
 il.load_rows,
 NULL AS mload_rows,
 CNT.trans_row_cnt AS target_rows,
  CASE
  WHEN CNT.trans_row_cnt IS NULL
  THEN 0
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
     FROM ldl_p_lew_process_ac.v_wawi_sys_interface_log_base
     WHERE dat_dayend >= DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)
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
     FROM ldl_p_lew_process_ac.v_wawi_sys_interface_log_l_0) AS t2) AS il
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON il.wh_loc_sid = WH.loc_sid_wh AND WH.dwh_actual_fg = 1
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_interface AS IFC ON il.system_key = IFC.system_key AND il.interface_key = IFC.interface_key
   
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_subsystem AS SSY ON il.system_key = SSY.system_key
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_country AS RC ON il.ctrcode = RC.country_iso_cd
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_country AS RCC ON RC.country_id = RCC.country_id
 LEFT JOIN ldl_p_lew_core_ac.v_wawi_org_store_skey AS STY ON RCC.client_id = STY.client_id AND il.orig_store_nr = STY.orig_store_nr
     AND il.dat_dayend BETWEEN STY.dat_rec_start AND STY.dat_rec_end -- Ermittlung surrogate key für store_id = 0

 LEFT JOIN ldl_p_lew_bil_ac.v_store AS ST ON RCC.client_id = ST.client_id AND ST.src_store_id = 0 AND ST.dwh_actual_fg =
   1
 LEFT JOIN ldl_p_lew_process_ac.v_wawi_sys_trans_cnt AS CNT ON il.system_key = CNT.system_key AND il.interface_key = CNT
       .interface_key AND RCC.client_id = CNT.client_id AND il.wh_loc_sid = CNT.wh_loc_sid AND STY.st_loc_sid = CNT.st_loc_sid
     AND il.dat_dayend = CNT.dat_dayend
WHERE il.system_key IN (2, 13);
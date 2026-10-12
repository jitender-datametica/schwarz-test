
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_SYS_INTERFACE_LOG_DES_2 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
    /*   
   #DescStart# 
   #$Revision: 11751 $, $LastChangedBy: mahdi $ 
   #SubjectAreas#: Systemtabellen   
   #DescEnd#   
   */ 
   
   SELECT DISTINCT   
      il.dc_load_id                 AS dc_load_id, 
   il.dc_server_id               AS dc_server_id,  
   il.system_key                 AS system_key, 
   ssy.system_desc               AS system_desc,   
   il.interface_key              AS interface_key, 
   ifc.comment_string            AS interface_desc,   
   il.ctrcode                    AS ctrcode, 
   rcc.client_id                 AS client_id,  
   wh.src_wh_id                  AS wh_id,   
   il.orig_store_nr              AS orig_store_nr, 
   COALESCE(st.loc_sid_store, 0) AS store_id,   
   il.dat_dayend                 AS dat_dayend, 
   il.dc_service_id              AS dc_service_id, 
   il.mail_rows                  AS mail_rows,  
   il.mail_bytes                 AS mail_bytes, 
   il.conv_rows                  AS conv_rows,  
   il.conv_bytes                 AS conv_bytes, 
   il.load_rows                  AS load_rows,  
   NULL                          AS mload_rows, 
   NULL                          AS target_rows,   
   CASE  
         WHEN tsspec.timestamp_end IS NOT NULL THEN 1 
         WHEN ts.timestamp_end IS NULL THEN  
            CASE  
               WHEN tsx.dat_last_busyear_end IS NOT NULL 
                AND il.system_key = 6  
                AND il.load_rows = tsx.l_0_cnt THEN 1 
               ELSE 0   
            END   
         ELSE 1   
      END                           AS trans_fg,   
   il.timestamp_load             AS timestamp_load,   
   il.source_sent_tmsp           AS source_sent_tmsp, 
   il.mail_in_tmsp               AS mail_in_tmsp   
   FROM  
   (  
      SELECT   
         dc_load_id, 
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
      FROM p_lew_process_ac.v_wawi_sys_interface_log_base_2   
      WHERE dat_dayend >= CURRENT_DATE- 2 
   
      UNION 
   
      SELECT   
         dc_load_id, 
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
      FROM p_lew_process_ac.v_wawi_sys_interface_log_l_0_2
   ) AS il  
   INNER JOIN p_lew_bil_ac.v_warehouse_2 AS wh 
   ON  wh.loc_sid_wh = il.wh_loc_sid   
   AND wh.dwh_actual_fg = 1   
   INNER JOIN p_lew_core_ac.v_wawi_ref_interface_2 AS ifc  
   ON  il.system_key    = ifc.system_key  
   AND il.interface_key = ifc.interface_key  
   INNER JOIN p_lew_core_ac.v_wawi_ref_subsystem_2 AS ssy  
   ON  il.system_key = ssy.system_key  
   INNER JOIN p_lew_core_ac.v_wawi_ref_country_2 AS rc  
   ON  rc.country_iso_cd = il.ctrcode  
   INNER JOIN p_lew_core_ac.v_wawi_ref_client_country_2 AS rcc   
   ON  rc.country_id = rcc.country_id  
   LEFT OUTER JOIN p_lew_bil_ac.v_store_2 AS st   
   ON  st.client_id = rcc.client_id 
   AND st.src_store_id = 0 
   AND st.dwh_actual_fg = 1   
   LEFT OUTER JOIN p_lew_process_ac.v_wawi_sys_dc_trans_status_int_2 AS ts   
   ON  ts.dc_server_id           = il.dc_server_id 
   AND ts.dc_load_id             = il.dc_load_id   
   AND ts.country_iso_cd         = il.ctrcode   
   AND ts.dat_dayend             = il.dat_dayend   
   --AND ZEROIFNULL(ts.wh_loc_sid) = ZEROIFNULL(il.wh_loc_sid) 
   AND ZEROIFNULL(ts.wh_id) = ZEROIFNULL(il.wh_loc_sid)  
   AND ts.interface_name         = ifc.process_name   
   LEFT OUTER JOIN p_lew_process_ac.v_wawi_sys_dc_trans_status_int_2 AS tsspec  
   ON  tsspec.country_iso_cd         = il.ctrcode  
   AND tsspec.dat_dayend             >= il.dat_dayend 
   --AND ZEROIFNULL(tsspec.wh_loc_sid) = ZEROIFNULL(il.wh_loc_sid)
   AND ZEROIFNULL(tsspec.wh_id) = ZEROIFNULL(il.wh_loc_sid)
   AND tsspec.interface_name         = ifc.process_name  
   AND tsspec.etl_type IN ('OVIS','DISPO_MASTER')  
   LEFT OUTER JOIN   
   (  
      -- Get all entries for transformations that belong to the last day of a busyear. This can be the 28th or the 29th of Feb. of the same year.  
      SELECT   
         tsi.dc_server_id, 
   tsi.dc_load_id,   
   tsi.country_iso_cd,  
   --tsi.wh_loc_sid, 
   tsi.wh_id,  
   tsi.interface_name,  
   tsi.dat_dayend,   
   tsi.l_0_cnt,   
   cal2.dat_last_busyear_end AS dat_last_busyear_end  
      FROM p_lew_process_ac.v_wawi_sys_dc_trans_status_int_2 AS tsi 
   INNER JOIN p_lew_core_ac.v_wawi_cal_calendarday_2 AS cal1  
   ON tsi.dat_dayend = cal1.dat_calendar  
   INNER JOIN  
   (  
      SELECT   
         busyear, 
   MAX(dat_calendar) AS dat_last_busyear_end 
         FROM p_lew_core_ac.v_wawi_cal_calendarday_2 
         GROUP BY 1  
      ) AS cal2   
   ON cal1.busyear = cal2.busyear   
   
   WHERE dat_dayend = dat_last_busyear_end   
   AND   timestamp_end IS NOT NULL  
) AS tsx 
   ON  il.dc_server_id  = tsx.dc_server_id   
   AND il.dc_load_id    = tsx.dc_load_id  
   AND il.ctrcode       = tsx.country_iso_cd 
   --AND il.wh_loc_sid    = tsx.wh_loc_sid   
   AND il.wh_loc_sid    = tsx.wh_id 
   AND il.dat_dayend    > tsx.dat_dayend  
   AND ifc.process_name = tsx.interface_name 
   
   WHERE il.system_key NOT IN (2,13)   
;

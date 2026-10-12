
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_SYS_INTERFACE_LOG_COEX_1 

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
         SELECT   
             dwh20.client_id, 
         loc_mk.src_wh_id    AS wh_id, 
         dwh20.wh_desc, 
         dwh20.loc_sid_store AS store_id, 
         dwh20.store_desc, 
         dwh20.orig_store_nr, 
         dwh20.system_key, 
         dwh20.system_desc,   
         dwh20.interface_key, 
         dwh20.interface_desc,   
         dwh20.dat_dayend, 
         dwh20.mcc_fg,  
         dwh20.mail_rows,  
         dwh20.conv_rows,  
         dwh20.load_rows,  
         dwh20.mload_rows, 
         dwh20.target_rows,   
         dwh20.trans_fg,   
         dwh20.source_sent_tmsp, 
         dwh20.mail_in_tmsp   
         FROM  
         (  
            SELECT   
               COALESCE(Soll.client_id, Lieferung.client_id)           AS client_id,   
         COALESCE(Soll.loc_sid_wh, Lieferung.loc_sid_wh)         AS loc_sid_wh,  
         COALESCE(Soll.wh_desc, Lieferung.wh_desc)               AS wh_desc,  
         COALESCE(Soll.loc_sid_store, Lieferung.loc_sid_store)   AS loc_sid_store,  
         COALESCE(Soll.store_desc, Lieferung.store_desc)         AS store_desc,  
         COALESCE(Soll.orig_store_nr, Lieferung.orig_store_nr)   AS orig_store_nr,  
         COALESCE(Soll.system_key, Lieferung.system_key)         AS system_key,  
         COALESCE(Soll.system_desc, Lieferung.system_desc)       AS system_desc, 
         COALESCE(Soll.interface_key, Lieferung.interface_key)   AS interface_key,  
         COALESCE(Soll.interface_desc, Lieferung.interface_desc) AS interface_desc, 
         COALESCE(Soll.dat_open, Lieferung.dat_dayend)           AS dat_dayend,  
         CASE  
                  WHEN Soll.mcc_fg IS NULL THEN 0 ELSE Soll.mcc_fg   
               END                                                     AS mcc_fg,   
         Lieferung.mail_rows, 
         Lieferung.conv_rows, 
         Lieferung.load_rows, 
         Lieferung.mload_rows,   
         Lieferung.target_rows,  
         Lieferung.trans_fg,  
         Lieferung.source_sent_tmsp,   
         Lieferung.mail_in_tmsp  
            FROM  
            (  
               SELECT   
                  sml.client_id, 
         sml.loc_sid_wh,   
         wh.wh_desc, 
         sml.loc_sid_store,   
         ossa.store_desc,  
         ossa.orig_store_nr,  
         rwi.system_key,   
         rwi.system_desc,  
         rwi.interface_key,   
         rwi.interface_desc,  
         sml.dat_open,  
         1 AS mcc_fg 
               FROM p_lew_bil_ac.v_sys_md_storelist_1 AS sml  
         INNER JOIN p_lew_core_ac.v_wawi_ref_wh_interface_1 AS rwi  
         ON  sml.client_id = rwi.client_id   
         AND sml.loc_sid_wh = rwi.wh_loc_sid 
         INNER JOIN p_lew_core_ac.v_wawi_org_store_act_1 AS ossa 
         ON  sml.loc_sid_store = ossa.st_loc_sid   
         AND sml.client_id = ossa.client_id  
         INNER JOIN p_lew_core_ac.v_wawi_org_wh_desc_1 AS wh  
         ON  sml.client_id = wh.client_id 
         AND sml.loc_sid_wh = wh.wh_loc_sid  
   
         WHERE rwi.system_key IN (2,13)   
         AND wh.language_id = 7  
         AND sml.dat_open >= CURRENT_DATE - 14  
   
         UNION ALL   
   
         SELECT   
            rwi.client_id, 
         rwi.wh_loc_sid AS loc_sid_wh, 
         wh.wh_desc, 
         st.loc_sid_store, 
         CASE  -- store_desc (Gesellschaft/Dienstleistung) on basis of src_wh_id instead of rwi.wh_loc_sid  
                     WHEN loc.src_wh_id = 0 THEN 'Dienstleistung' 
                     ELSE 'Gesellschaft'  
                  END            AS store_desc, 
         0             AS orig_store_nr,  
         rwi.system_key,   
         rwi.system_desc,  
         rwi.interface_key,   
         rwi.interface_desc,  
         c.dat_calendar,   
         NULL          AS mcc_fg 
               FROM p_lew_core_ac.v_wawi_ref_wh_interface_1 AS rwi  
         INNER JOIN p_lew_bil_ac.v_warehouse_1 AS loc   
         ON  rwi.wh_loc_sid = loc.loc_sid_wh 
         AND rwi.client_id = loc.client_id   
         AND loc.dwh_actual_fg = 1  
         INNER JOIN p_lew_bil_ac.v_store_1 AS st  
         ON  st.client_id = rwi.client_id 
         AND st.src_store_id = 0 
         AND st.dwh_actual_fg = 1   
         INNER JOIN p_lew_core_ac.v_wawi_cal_calendarday_1 c  
         ON  c.dat_calendar BETWEEN rwi.dat_rec_start AND rwi.dat_rec_end  
         INNER JOIN p_lew_core_ac.v_wawi_org_wh_desc_1 wh  
         ON  rwi.client_id = wh.client_id 
         AND rwi.wh_loc_sid = wh.wh_loc_sid  
   
         WHERE c.dat_calendar < CURRENT_DATE 
         AND system_key NOT IN (2,13)  
         AND wh.language_id = 7  
         AND c.dat_calendar >= CURRENT_DATE - 14   
      ) AS Soll   
         FULL OUTER JOIN   
         (  
            SELECT   
               sil.client_id, 
         loc.loc_sid_wh,   
         wh.wh_desc, 
         sil.loc_sid_store,   
         CASE  -- store_desc (Gesellschaft/Dienstleistung) on basis of scr_wh_id and scr_store_id instead of loc_sid_wh and loc_sid_store 
                     WHEN st.src_store_id = 0 AND sil.src_wh_id = 0  THEN 'Dienstleistung'   
                     WHEN st.src_store_id = 0 AND sil.src_wh_id <> 0 THEN 'Gesellschaft'  
                     ELSE ossa.store_desc 
                  END  AS store_desc,  
         sil.orig_store_nr,   
         sil.system_key,   
         sil.system_desc,  
         sil.interface_key,   
         sil.interface_desc,  
         sil.dat_dayend,   
         sil.mail_rows, 
         sil.conv_rows, 
         sil.load_rows, 
         sil.mload_rows,   
         sil.target_rows,  
         sil.trans_fg,  
         sil.source_sent_tmsp,   
         sil.mail_in_tmsp  
               FROM  
               (  
                  SELECT   
                     ifl.dc_load_id,   
         ifl.dc_server_id, 
         ifl.system_key,   
         ifl.system_desc,  
         ifl.interface_key,   
         ifl.interface_desc,  
         ifl.ctrcode,   
         ifl.client_id, 
         ifl.wh_id         AS src_wh_id,  
         ifl.orig_store_nr,   
         ifl.store_id      AS loc_sid_store, 
         ifl.dat_dayend,   
         ifl.dc_service_id,   
         ifl.mail_rows, 
         ifl.mail_bytes,   
         ifl.conv_rows, 
         ifl.conv_bytes,   
         ifl.load_rows, 
         ifl.mload_rows,   
         ifl.target_rows,  
         ifl.trans_fg,  
         ifl.timestamp_load,  
         ifl.source_sent_tmsp,   
         ifl.mail_in_tmsp  
                  FROM p_lew_mart_msi.v_sys_interface_log_kasse_1 AS ifl  
         WHERE ifl.system_key IN (2,13) AND ifl.dat_dayend >= CURRENT_DATE - 14  
   
         UNION 
   
         SELECT   
            ifl.dc_load_id,   
         ifl.dc_server_id, 
         ifl.system_key,   
         ifl.system_desc,  
         ifl.interface_key,   
         ifl.interface_desc,  
         ifl.ctrcode,   
         ifl.client_id, 
         ifl.wh_id         AS src_wh_id,  
         ifl.orig_store_nr,   
         ifl.store_id      AS loc_sid_store, 
         ifl.dat_dayend,   
         ifl.dc_service_id,   
         ifl.mail_rows, 
         ifl.mail_bytes,   
         ifl.conv_rows, 
         ifl.conv_bytes,   
         ifl.load_rows, 
         ifl.mload_rows,   
         ifl.target_rows,  
         ifl.trans_fg,  
         ifl.timestamp_load,  
         ifl.source_sent_tmsp,   
         ifl.mail_in_tmsp  
                  FROM p_lew_mart_msi.v_sys_interface_log_des_1 AS ifl 
         WHERE ifl.system_key NOT IN (2,13) AND ifl.dat_dayend >= CURRENT_DATE - 14 
   
         UNION 
   
         SELECT   
            ifl.dc_load_id,   
         ifl.dc_server_id, 
         ifl.system_key,   
         ifl.system_desc,  
         ifl.interface_key,   
         ifl.interface_desc,  
         ifl.ctrcode,   
         ifl.client_id, 
         loc.src_wh_id, 
         ifl.orig_store_nr,   
         ifl.st_loc_sid    AS loc_sid_store, 
         ifl.dat_dayend,   
         ifl.dc_service_id,   
         ifl.mail_rows, 
         ifl.mail_bytes,   
         ifl.conv_rows, 
         ifl.conv_bytes,   
         ifl.load_rows, 
         ifl.mload_rows,   
         ifl.target_rows,  
         ifl.trans_fg,  
         ifl.timestamp_load,  
         ifl.source_sent_tmsp,   
         ifl.mail_in_tmsp  
                  FROM p_lew_core_ac.v_wawi_sys_interface_log_1 AS ifl 
         INNER JOIN p_lew_bil_ac.v_warehouse_1 AS loc   
         ON  ifl.wh_loc_sid = loc.loc_sid_wh 
         AND ifl.client_id = loc.client_id   
         AND loc.dwh_actual_fg = 1  
   
         WHERE dat_dayend >= CURRENT_DATE - 14  
      ) AS sil 
         INNER JOIN p_lew_bil_ac.v_warehouse_1 AS loc   
         ON  sil.src_wh_id = loc.src_wh_id   
         AND sil.client_id  = loc.client_id  
         AND loc.dwh_actual_fg = 1  
         INNER JOIN p_lew_bil_ac.v_store_1 AS st  
         ON  st.client_id = sil.client_id 
         AND st.loc_sid_store = sil.loc_sid_store  
         AND st.dwh_actual_fg = 1   
         LEFT OUTER JOIN p_lew_core_ac.v_wawi_org_store_act_1 AS ossa  
         ON  sil.loc_sid_store = ossa.st_loc_sid   
         AND sil.client_id     = ossa.client_id 
         INNER JOIN p_lew_core_ac.v_wawi_org_wh_desc_1 AS wh  
         ON  sil.client_id  = wh.client_id   
         AND loc.loc_sid_wh = wh.wh_loc_sid  
   
         WHERE NOT(ossa.store_desc IS NULL AND st.src_store_id <> 0) 
         AND wh.language_id = 7  
   
         QUALIFY Row_Number() OVER  
         (  
            PARTITION BY   
             sil.client_id 
            ,loc.loc_sid_wh   
            ,sil.loc_sid_store   
            ,sil.system_key   
            ,sil.interface_key   
            ,sil.dat_dayend   
            ORDER BY 
             trans_fg DESC NULLS LAST  
            ,timestamp_load DESC NULLS LAST  
            ,dc_load_id DESC NULLS LAST   
            ,dc_server_id ASC 
            ,mload_rows DESC NULLS LAST   
         ) = 1 
      ) AS Lieferung 
         ON  Soll.client_id     = Lieferung.client_id 
         AND Soll.loc_sid_wh    = Lieferung.loc_sid_wh   
         AND Soll.loc_sid_store = Lieferung.loc_sid_store   
         AND Soll.system_key    = Lieferung.system_key   
         AND Soll.interface_key = Lieferung.interface_key   
         AND Soll.dat_open      = Lieferung.dat_dayend   
      ) AS dwh20  
         INNER JOIN p_lew_bil_ac.v_warehouse_1 AS loc_mk   
         ON  dwh20.loc_sid_wh = loc_mk.loc_sid_wh  
         AND dwh20.client_id = loc_mk.client_id 
         AND loc_mk.dwh_actual_fg = 1  
;

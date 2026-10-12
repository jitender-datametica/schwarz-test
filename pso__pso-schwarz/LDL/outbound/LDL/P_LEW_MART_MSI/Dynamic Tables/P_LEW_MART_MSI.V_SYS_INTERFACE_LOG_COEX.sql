CREATE OR REPLACE TABLE ldl_p_lew_mart_msi.v_sys_interface_log_coex AS
-- store_desc (Gesellschaft/Dienstleistung) on basis of src_wh_id instead of rwi.wh_loc_sid

-- store_desc (Gesellschaft/Dienstleistung) on basis of scr_wh_id and scr_store_id instead of loc_sid_wh and loc_sid_store

SELECT dwh20.client_id,
 LOC_MK.src_wh_id AS wh_id,
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
FROM (SELECT COALESCE(Soll.client_id, Lieferung.client_id) AS client_id,
   COALESCE(Soll.loc_sid_wh, Lieferung.loc_sid_wh) AS loc_sid_wh,
   COALESCE(Soll.wh_desc, Lieferung.wh_desc) AS wh_desc,
   COALESCE(Soll.loc_sid_store, Lieferung.loc_sid_store) AS loc_sid_store,
   COALESCE(Soll.store_desc, Lieferung.store_desc) AS store_desc,
   COALESCE(Soll.orig_store_nr, Lieferung.orig_store_nr) AS orig_store_nr,
   COALESCE(Soll.system_key, Lieferung.system_key) AS system_key,
   COALESCE(Soll.system_desc, Lieferung.system_desc) AS system_desc,
   COALESCE(Soll.interface_key, Lieferung.interface_key) AS interface_key,
   COALESCE(Soll.interface_desc, Lieferung.interface_desc) AS interface_desc,
   COALESCE(Soll.dat_open, Lieferung.dat_dayend) AS dat_dayend,
    CASE
    WHEN Soll.mcc_fg IS NULL
    THEN 0
    ELSE Soll.mcc_fg
    END AS mcc_fg,
   Lieferung.mail_rows,
   Lieferung.conv_rows,
   Lieferung.load_rows,
   Lieferung.mload_rows,
   Lieferung.target_rows,
   Lieferung.trans_fg,
   Lieferung.source_sent_tmsp,
   Lieferung.mail_in_tmsp
  FROM (SELECT SML.client_id,
      SML.loc_sid_wh,
      WH.wh_desc,
      SML.loc_sid_store,
      OSSA.store_desc,
      OSSA.orig_store_nr,
      RWI.system_key,
      RWI.system_desc,
      RWI.interface_key,
      RWI.interface_desc,
      SML.dat_open,
      1 AS mcc_fg
     FROM ldl_p_lew_bil_ac.v_sys_md_storelist AS SML
      INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_wh_interface AS RWI ON SML.client_id = RWI.client_id AND SML.loc_sid_wh =
        RWI.wh_loc_sid
      INNER JOIN ldl_p_lew_core_ac.v_wawi_org_store_act AS OSSA ON SML.loc_sid_store = OSSA.st_loc_sid AND SML.client_id
         = OSSA.client_id
      INNER JOIN ldl_p_lew_core_ac.v_wawi_org_wh_desc AS WH ON SML.client_id = WH.client_id AND SML.loc_sid_wh = WH.wh_loc_sid
        
     WHERE RWI.system_key IN (2, 13)
      AND WH.language_id = 7
      AND SML.dat_open >= DATE_SUB(CURRENT_DATE, INTERVAL 14 DAY)
     UNION ALL
     SELECT RWI.client_id,
      RWI.wh_loc_sid AS loc_sid_wh,
      WH.wh_desc,
      ST.loc_sid_store,
       CASE
       WHEN LOC.src_wh_id = 0
       THEN 'Dienstleistung'
       ELSE 'Gesellschaft'
       END AS store_desc,
      0 AS orig_store_nr,
      RWI.system_key,
      RWI.system_desc,
      RWI.interface_key,
      RWI.interface_desc,
      C.dat_calendar,
      CAST(NULL AS INTEGER) AS mcc_fg
     FROM ldl_p_lew_core_ac.v_wawi_ref_wh_interface AS RWI
      INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS LOC ON RWI.wh_loc_sid = LOC.loc_sid_wh AND RWI.client_id = LOC.client_id
          AND LOC.dwh_actual_fg = 1
      INNER JOIN ldl_p_lew_bil_ac.v_store AS ST ON RWI.client_id = ST.client_id AND ST.src_store_id = 0 AND ST.dwh_actual_fg
         = 1
      INNER JOIN ldl_p_lew_core_ac.v_wawi_cal_calendarday AS C ON C.dat_calendar BETWEEN RWI.dat_rec_start AND RWI.dat_rec_end
       
      INNER JOIN ldl_p_lew_core_ac.v_wawi_org_wh_desc AS WH ON RWI.client_id = WH.client_id AND RWI.wh_loc_sid = WH.wh_loc_sid
        
     WHERE C.dat_calendar < CURRENT_DATE
      AND WH.language_id = 7
      AND C.dat_calendar >= DATE_SUB(CURRENT_DATE, INTERVAL 14 DAY)
      AND RWI.system_key NOT IN (2, 13)) AS Soll
   FULL JOIN (SELECT sil.client_id,
     LOC0.loc_sid_wh,
     WH0.wh_desc,
     sil.loc_sid_store,
      CASE
      WHEN ST0.src_store_id = 0 AND sil.src_wh_id = 0
      THEN 'Dienstleistung'
      WHEN ST0.src_store_id = 0 AND sil.src_wh_id <> 0
      THEN 'Gesellschaft'
      ELSE OSSA.store_desc
      END AS store_desc,
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
    FROM ((SELECT dc_load_id,
         dc_server_id,
         system_key,
         system_desc,
         interface_key,
         interface_desc,
         ctrcode,
         client_id,
         wh_id AS src_wh_id,
         orig_store_nr,
         store_id AS loc_sid_store,
         dat_dayend,
         dc_service_id,
         mail_rows,
         mail_bytes,
         conv_rows,
         conv_bytes,
         load_rows,
         CAST(mload_rows AS INTEGER) AS mload_rows,
         target_rows,
         trans_fg,
         timestamp_load,
         source_sent_tmsp,
         mail_in_tmsp
        FROM ldl_p_lew_mart_msi.v_sys_interface_log_kasse AS IFL
        WHERE system_key IN (2, 13)
         AND dat_dayend >= DATE_SUB(CURRENT_DATE, INTERVAL 14 DAY)
        UNION DISTINCT
        SELECT dc_load_id,
         dc_server_id,
         system_key,
         system_desc,
         interface_key,
         interface_desc,
         ctrcode,
         client_id,
         wh_id AS src_wh_id,
         orig_store_nr,
         store_id AS loc_sid_store,
         dat_dayend,
         dc_service_id,
         mail_rows,
         mail_bytes,
         conv_rows,
         conv_bytes,
         load_rows,
         CAST(mload_rows AS INTEGER) AS mload_rows,
         CAST(target_rows AS BIGNUMERIC) AS target_rows,
         trans_fg,
         timestamp_load,
         source_sent_tmsp,
         mail_in_tmsp
        FROM ldl_p_lew_mart_msi.v_sys_interface_log_des AS IFL
        WHERE dat_dayend >= DATE_SUB(CURRENT_DATE, INTERVAL 14 DAY)
         AND system_key NOT IN (2, 13))
       UNION DISTINCT
       SELECT IFL.dc_load_id,
        IFL.dc_server_id,
        IFL.system_key,
        IFL.system_desc,
        IFL.interface_key,
        IFL.interface_desc,
        IFL.ctrcode,
        IFL.client_id,
        LOC.src_wh_id,
        IFL.orig_store_nr,
        IFL.st_loc_sid AS loc_sid_store,
        IFL.dat_dayend,
        IFL.dc_service_id,
        IFL.mail_rows,
        IFL.mail_bytes,
        IFL.conv_rows,
        IFL.conv_bytes,
        IFL.load_rows,
        IFL.mload_rows,
        IFL.target_rows,
        IFL.trans_fg,
        IFL.timestamp_load,
        IFL.source_sent_tmsp,
        IFL.mail_in_tmsp
       FROM ldl_p_lew_core_ac.v_wawi_sys_interface_log AS IFL
        INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS LOC ON IFL.wh_loc_sid = LOC.loc_sid_wh AND IFL.client_id = LOC.client_id
            AND LOC.dwh_actual_fg = 1
       WHERE IFL.dat_dayend >= DATE_SUB(CURRENT_DATE, INTERVAL 14 DAY)) AS sil
     INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS LOC0 ON sil.src_wh_id = LOC0.src_wh_id AND sil.client_id = LOC0.client_id
         AND LOC0.dwh_actual_fg = 1
     INNER JOIN ldl_p_lew_bil_ac.v_store AS ST0 ON sil.client_id = ST0.client_id AND sil.loc_sid_store = ST0.loc_sid_store
         AND ST0.dwh_actual_fg = 1
     LEFT JOIN ldl_p_lew_core_ac.v_wawi_org_store_act AS OSSA ON sil.loc_sid_store = OSSA.st_loc_sid AND sil.client_id =
       OSSA.client_id
     INNER JOIN ldl_p_lew_core_ac.v_wawi_org_wh_desc AS WH0 ON sil.client_id = WH0.client_id AND LOC0.loc_sid_wh = WH0.wh_loc_sid
       
    WHERE (OSSA.store_desc IS NOT NULL OR ST0.src_store_id = 0)
     AND WH0.language_id = 7
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(sil.client_id AS STRING), LOC0.loc_sid_wh, CAST(sil.loc_sid_store AS STRING)
          , CAST(sil.system_key AS STRING), CAST(sil.interface_key AS STRING), sil.dat_dayend ORDER BY sil.trans_fg
          IS NULL, sil.trans_fg, sil.timestamp_load IS NULL, sil.timestamp_load, sil.dc_load_id IS NULL, sil.dc_load_id
          , sil.dc_server_id IS NULL, sil.dc_server_id, sil.mload_rows IS NULL, sil.mload_rows)) = 1) AS Lieferung ON
         Soll.client_id = Lieferung.client_id AND Soll.loc_sid_wh = Lieferung.loc_sid_wh AND Soll.loc_sid_store =
        Lieferung.loc_sid_store AND Soll.system_key = Lieferung.system_key AND Soll.interface_key = Lieferung.interface_key
       AND Soll.dat_open = Lieferung.dat_dayend) AS dwh20
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS LOC_MK ON dwh20.loc_sid_wh = LOC_MK.loc_sid_wh AND dwh20.client_id = LOC_MK
    .client_id AND LOC_MK.dwh_actual_fg = 1;
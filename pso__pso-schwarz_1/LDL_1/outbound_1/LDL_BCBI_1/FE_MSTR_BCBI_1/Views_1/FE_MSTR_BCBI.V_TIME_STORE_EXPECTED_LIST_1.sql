CREATE OR REPLACE VIEW ldl_bcbi_fe_mstr_bcbi.v_time_store_expected_list_1 AS SELECT M.client_id,
 C.country_iso,
 wh.src_wh_id AS wh_id,
 M.loc_sid_wh,
 lsp_1.wh_desc,
 wha.wh_type,
 M.loc_sid_store,
 lsp_1.orig_store_nr,
 lsp_1.store_desc,
 typ.source_system,
 M.dat_open
FROM ldl_bcbi_fe_mstr_bcbi.t_sys_md_storelist_1 AS M
 INNER JOIN (SELECT DISTINCT src_wh_id,
   loc_sid_wh
  FROM ldl_bcbi_fe_mstr_bcbi.t_warehouse_1) AS wh ON M.loc_sid_wh = wh.loc_sid_wh
 INNER JOIN ldl_bcbi_fe_mstr_bcbi.t_country_1 AS C ON M.client_id = C.client_id
 INNER JOIN (SELECT DISTINCT client_id,
   wh_id,
   wh_type,
   wh_active_fg
  FROM ldl_bcbi_fe_mstr_bcbi.t_dataavail_wh_expected_list_1
  WHERE dat_rec_end = DATE '9999-12-31') AS wha ON M.client_id = wha.client_id AND wh.src_wh_id = wha.wh_id AND wha.wh_active_fg
  
 INNER JOIN (SELECT DISTINCT client_id,
   st_loc_sid,
   orig_store_nr,
   wh_loc_sid,
   wh_desc,
   store_desc
  FROM ldl_bcbi_fe_mstr_bcbi.t_wawi_sys_load_status_present_1
  WHERE st_loc_sid <> 0
   AND dat_dayend > DATE_SUB(CURRENT_DATE, INTERVAL 90 DAY)
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), CAST(st_loc_sid AS STRING), CAST(orig_store_nr AS STRING)
        , CAST(wh_loc_sid AS STRING) ORDER BY dat_dayend IS NULL DESC, dat_dayend DESC)) = 1) AS lsp_1 ON M.client_id =
    lsp_1.client_id AND M.loc_sid_store = lsp_1.st_loc_sid AND M.loc_sid_wh = lsp_1.wh_loc_sid
 LEFT JOIN ((SELECT DISTINCT GPS.client_id,
     GPS.loc_sid,
     'GPS' AS source_system
    FROM ldl_bcbi_fe_mstr_bcbi.t_time_tracking_record_1 AS GPS
     INNER JOIN (SELECT *
      FROM ldl_bcbi_fe_mstr_bcbi.t_time_type_hist_1
      WHERE active_to_dt = DATE '9999-12-30') AS TYPE ON GPS.time_type_sid = TYPE.time_type_sid
    WHERE TYPE.performance_relevant_fg = 1
    UNION DISTINCT
    SELECT DISTINCT PTM.client_id,
     PTM.loc_sid,
     'PTM' AS source_system
    FROM ldl_bcbi_fe_mstr_bcbi.t_time_tracking_period_1 AS PTM
     INNER JOIN (SELECT *
      FROM ldl_bcbi_fe_mstr_bcbi.t_time_type_hist_1
      WHERE active_to_dt = DATE '9999-12-30') AS TYPE ON PTM.time_type_sid = TYPE.time_type_sid
    WHERE TYPE.performance_relevant_fg = 1)
   UNION DISTINCT
   SELECT DISTINCT GPSMISS.client_id,
    GPSMISS.loc_sid,
    'GPS' AS source_system
   FROM ldl_bcbi_fe_mstr_bcbi.t_time_tracking_day_1 AS GPSMISS
    INNER JOIN (SELECT *
     FROM ldl_bcbi_fe_mstr_bcbi.t_time_type_hist_1
     WHERE active_to_dt = DATE '9999-12-30') AS TYPE ON GPSMISS.time_type_sid = TYPE.time_type_sid
   WHERE TYPE.performance_relevant_fg = 1) AS typ ON M.client_id = typ.client_id AND M.loc_sid_store = typ.loc_sid
WHERE M.dat_open BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 15 DAY) AND (DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY));
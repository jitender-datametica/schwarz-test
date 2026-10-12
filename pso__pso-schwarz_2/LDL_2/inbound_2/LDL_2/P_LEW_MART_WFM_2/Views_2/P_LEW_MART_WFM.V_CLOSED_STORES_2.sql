CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_CLOSED_STORES_2
AS
   /* v_sys_md_storelist_2 contains the all dates which store opens.
      The aim of this SQL is to list up the store closed dates in the next 15 dates */
   SELECT
   cntry.src_country_lidl_cd AS country_lidl_cd
   , cal.cal_dt                AS dat_closed  /* the dates not in md_storelist */
   , st2wh.orig_store_nr

   FROM p_lew_bil_ac.v_store_to_warehouse_2 st2wh
   INNER JOIN p_lew_core_ac.v_country_2 cntry
   ON st2wh.client_id = cntry.country_sid
   INNER JOIN p_lew_core_ac.v_location_2 loc
   ON st2wh.client_id = loc.client_id
   AND st2wh.loc_sid_store = loc.loc_sid
   AND loc.wh_store_mark = 'A'
   INNER JOIN p_lew_core_ac.v_location_hist_2 loc_hist
   ON loc.loc_sid = loc_hist.loc_sid
   AND loc_hist.deleted_fg = 0
   AND CURRENT_DATE BETWEEN loc_hist.dwh_valid_from AND loc_hist.dwh_valid_to
   INNER JOIN p_lew_core_ac.v_cal_calendarday_2 cal
   ON cal.cal_dt BETWEEN CURRENT_DATE AND CURRENT_DATE +15
    /* pick up the dates which are not in md_storelist. That means store is closed  */
   AND cal.cal_dt NOT IN (
       SELECT dat_open
       FROM p_lew_bil_ac.v_sys_md_storelist_2 mdsl
   WHERE dat_open BETWEEN CURRENT_DATE AND CURRENT_DATE +15
     AND mdsl.client_id = st2wh.client_id
     AND mdsl.loc_sid_wh = st2wh.loc_sid_wh
     AND mdsl.loc_sid_store = st2wh.loc_sid_store
   )
   INNER JOIN (
/* Uses max(dat_open) to determine the chronological end of the multiday store list */
   SELECT
     client_id
   , loc_sid_wh
   , MAX(dat_open) AS mcc_list_valid_until
   FROM p_lew_bil_ac.v_sys_md_storelist_2
   GROUP BY client_id, loc_sid_wh
   ) msl_maxend
   ON msl_maxend.client_id = st2wh.client_id
   AND msl_maxend.loc_sid_wh = st2wh.loc_sid_wh
   AND cal.cal_dt <= msl_maxend.mcc_list_valid_until
   /*Interpret the store as "open" if the calendar_2 date is later than 
    the end of the multiday store list*/

   WHERE st2wh.dwh_actual_fg = 1
   /* Only select opend stores resp. stores which open in the next 14 days */
   AND CURRENT_DATE + 14 > loc.opening_dt
   AND (loc_hist.test_store_fg IS NULL              /* 18.09.18 added        */
    OR  loc_hist.test_store_fg  <> 1 )              /* Exclude test_2 stores   */
   AND (loc.closing_dt IS NULL
    OR CAST(loc.closing_dt AS DATE) > CURRENT_DATE) /* Exclude closed stores */
   /* Exclude stores which represent a warehouse 
   AND (st2wh.client_id, st2wh.orig_store_nr) NOT IN (
       SELECT client_id,src_wh_id
       FROM p_lew_core_ac.v_location_2
       WHERE CURRENT_DATE > opening_dt
       AND wh_store_mark = 'B') */
   AND st2wh.orig_store_nr <> st2wh.orig_wh_nr 
;
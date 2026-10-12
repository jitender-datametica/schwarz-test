/* v_sys_md_storelist contains the all dates which store opens.
      The aim of this SQL is to list up the store closed dates in the next 15 dates */
CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_closed_stores AS /* the dates not in md_storelist */
/* pick up the dates which are not in md_storelist. That means store is closed */
/* Uses max(dat_open) to determine the chronological end of the multiday store list */
/* Only select opend stores resp. stores which open in the next 14 days */ /* 18.09.18 added */
/* Exclude test stores */ /* Exclude closed stores */
/* Exclude stores which represent a warehouse 
   AND (st2wh.client_id, st2wh.orig_store_nr) NOT IN (
       SELECT client_id,src_wh_id
       FROM LDL.p_lew_core_ac.v_location
       WHERE CURRENT_DATE > opening_dt
       AND wh_store_mark = 'B') */
SELECT t1.src_country_lidl_cd AS country_lidl_cd,
 t1.cal_dt AS dat_closed,
 t1.orig_store_nr
FROM (SELECT 
      ST2WH.client_id
      ,ST2WH.loc_sid_store
      ,ST2WH.orig_store_nr
      ,ST2WH.loc_sid_wh
      ,ST2WH.orig_wh_nr
      ,ST2WH.dwh_valid_from
      ,ST2WH.dwh_valid_to
      ,ST2WH.dwh_actual_fg
      ,ST2WH.active_fg
      ,ST2WH.future_active_fg
      ,CAL.cal_dt
      ,LOC.opening_dt
      ,LOC_HIST.test_store_fg
      ,LOC.closing_dt
      ,CNTRY.src_country_lidl_cd
  FROM ldl_p_lew_bil_ac.v_store_to_warehouse AS ST2WH
   INNER JOIN ldl_p_lew_core_ac.v_country AS CNTRY ON ST2WH.client_id = CNTRY.country_sid
   INNER JOIN ldl_p_lew_core_ac.v_location AS LOC ON ST2WH.client_id = LOC.client_id AND ST2WH.loc_sid_store = LOC.loc_sid
       AND LOC.wh_store_mark = 'A'
   INNER JOIN ldl_p_lew_core_ac.v_location_hist AS LOC_HIST ON LOC.loc_sid = LOC_HIST.loc_sid AND LOC_HIST.deleted_fg =
      0 AND CURRENT_DATE BETWEEN LOC_HIST.dwh_valid_from AND LOC_HIST.dwh_valid_to
   INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday AS CAL ON CAL.cal_dt BETWEEN CURRENT_DATE AND (DATE_ADD(CURRENT_DATE,
      INTERVAL 15 DAY))
  WHERE CAL.cal_dt NOT IN (SELECT dat_open
     FROM ldl_p_lew_bil_ac.v_sys_md_storelist AS MDSL
     WHERE dat_open BETWEEN CURRENT_DATE AND (DATE_ADD(CURRENT_DATE, INTERVAL 15 DAY))
      AND client_id = ST2WH.client_id
      AND loc_sid_wh = ST2WH.loc_sid_wh
      AND loc_sid_store = ST2WH.loc_sid_store)) AS t1
 INNER JOIN (SELECT client_id,
   loc_sid_wh,
   MAX(dat_open) AS mcc_list_valid_until
  FROM ldl_p_lew_bil_ac.v_sys_md_storelist
  GROUP BY client_id,
   loc_sid_wh) AS msl_maxend ON t1.client_id = msl_maxend.client_id AND t1.loc_sid_wh = msl_maxend.loc_sid_wh AND t1.cal_dt
    <= msl_maxend.mcc_list_valid_until
   /* Interpret the store as "open" if the calendar date is later than 
    the end of the multiday store list */
WHERE t1.dwh_actual_fg = 1
 AND DATE_ADD(CURRENT_DATE, INTERVAL 14 DAY) > t1.opening_dt
 AND (t1.test_store_fg IS NULL OR t1.test_store_fg <> 1)
 AND (t1.closing_dt IS NULL OR DATE(t1.closing_dt) > CURRENT_DATE)
 AND t1.orig_store_nr <> t1.orig_wh_nr;
/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_BW_OPEN_DAYS_STORE_MTH
#----------------------------------------------------------------------------
# History:
#  1.0  12.05.2023    Ulrich Ross               Init, User Story 476747
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_CS.V_BW_OPEN_DAYS_STORE_MTH(
   calmonth  
  ,client_id
  ,sumdaycount
  ,sumdaycount_ytd
) 
AS(
  WITH open_days_store_mth AS (
    SELECT	
       cal.cy_month                     AS cy_month
      ,store_merge.client_id            AS client_id
      ,SUM(cnt_store_week.day_cnt)      AS day_cnt
    FROM	p_lew_mart_msi_ac.v_day_cnt_store_week	        AS cnt_store_week
    INNER JOIN	p_lew_mart_msi_ac.v_cal_calendarday	    AS cal
      ON 	cnt_store_week.dat_calendar = cal.dat_calendar
    INNER JOIN	p_lew_mart_msi_ac.v_org_store_merge	    AS store_merge
      ON 	cnt_store_week.client_id = store_merge.client_id 
      AND cnt_store_week.store_id = store_merge.store_id
    WHERE	cal.cy_month BETWEEN TO_VARCHAR(DATEADD('YEAR', -6, CURRENT_DATE),'YYYYMM') AND TO_VARCHAR(CURRENT_DATE,'YYYYMM')
     AND store_merge.aspect_id = 1
     AND store_merge.mis_store_active_fg = 1
     AND store_merge.dashboard_relevant_fg = 1
    GROUP BY	
       cal.cy_month
      ,store_merge.client_id
  )

  , open_days_store_day AS (
    SELECT	
       cal.dat_calendar               AS dat_calendar
      ,store_merge.client_id          AS client_id
      ,store_merge.store_id           AS store_id
      ,SUM(cnt_store_day.day_cnt)     AS day_cnt
      
    FROM	p_lew_mart_msi_ac.v_day_cnt_store_week	        AS cnt_store_day
    INNER JOIN	p_lew_mart_msi_ac.v_org_store_merge	    AS store_merge
      ON 	cnt_store_day.client_id = store_merge.client_id 
      AND cnt_store_day.store_id = store_merge.store_id
    INNER JOIN	p_lew_mart_msi_ac.v_cal_calendarday	    AS cal
      ON  cnt_store_day.dat_calendar = cal.dat_calendar
    WHERE	cal.cy_month BETWEEN TO_VARCHAR(DATEADD('YEAR', -6, CURRENT_DATE),'YYYYMM') AND TO_VARCHAR(CURRENT_DATE,'YYYYMM')
      AND store_merge.aspect_id = 1
      AND store_merge.mis_store_active_fg = 1
      AND store_merge.dashboard_relevant_fg = 1
    GROUP BY	
       cal.dat_calendar
      ,store_merge.client_id
      ,store_merge.store_id
  )

  , open_days_store_day_by_acc AS (
    SELECT	
       cal.cy_month                             AS cy_month
      ,store_merge.client_id                    AS client_id
      ,SUM(open_days_store_day.day_cnt)         AS day_cnt_acc
    FROM	open_days_store_day	                                      AS open_days_store_day
    INNER JOIN	p_lew_mart_msi_ac.v_cal_busyear_cum	  AS by_acc
      ON 	open_days_store_day.dat_calendar = by_acc.dat_byr_cum
    INNER JOIN	p_lew_mart_msi_ac.v_cal_calendarday	  AS cal
      ON 	by_acc.dat_calendar = cal.dat_calendar
    INNER JOIN	p_lew_mart_msi_ac.v_org_all_store_merge	            AS store_merge
      ON 	open_days_store_day.client_id = store_merge.client_id
      AND open_days_store_day.store_id = store_merge.move_to_store_id
    WHERE	store_merge.aspect_id = 1
      AND store_merge.dashboard_relevant_fg = 1
      AND by_acc.dat_calendar
        IN	( SELECT	
                MAX(cal.dat_calendar)
              FROM	p_lew_mart_msi_ac.v_cal_calendarday	AS cal
              WHERE cal.cy_month BETWEEN TO_VARCHAR(DATEADD('YEAR', -6, CURRENT_DATE),'YYYYMM') AND TO_VARCHAR(CURRENT_DATE,'YYYYMM')
              GROUP BY cal.cy_month
            )
    GROUP BY	
       cal.cy_month
      ,store_merge.client_id
  )

  SELECT	
     open_days_store_mth.cy_month             AS cy_month
    ,open_days_store_mth.client_id            AS client_id
    ,open_days_store_mth.day_cnt              AS sumdaycount
    ,open_days_store_day_by_acc.day_cnt_acc   AS sumdaycount_ytd
  FROM open_days_store_mth                                  AS open_days_store_mth    
  FULL OUTER JOIN	open_days_store_day_by_acc	              AS open_days_store_day_by_acc
    ON  open_days_store_mth.client_id = open_days_store_day_by_acc.client_id 
    AND open_days_store_mth.cy_month = open_days_store_day_by_acc.cy_month
  WHERE open_days_store_mth.cy_month IS NOT NULL
);
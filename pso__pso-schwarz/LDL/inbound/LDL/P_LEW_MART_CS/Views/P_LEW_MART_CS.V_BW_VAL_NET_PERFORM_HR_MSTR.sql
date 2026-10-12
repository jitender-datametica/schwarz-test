/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_BW_VAL_NET_PERFORM_HR_MSTR
#----------------------------------------------------------------------------
# History:
#  1.0  13.03.2023    Ulrich Ross               Init, User Story 449330
#  1.1  19.04.2023    Ulrich Ross               User Story 466935, remove columns and change values in column client_desc
#  1.2  23.06.2023    Ulrich Ross               User Story 493455, Change attribut country_cd to country_iso_cd
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_CS.V_BW_VAL_NET_PERFORM_HR_MSTR(
    byr
  , client_id
  , client_desc
  , store_id
  , aspect_id
  , orig_store_nr
  , dat_calendar1
  , cy_month
  , wjxbfs1
  , wjxbfs3
) 
AS(
  WITH turnover AS (
    SELECT	
        cal.dat_calendar                AS dat_calendar
      , store.move_to_store_id          AS store_id
      , store.aspect_id                 AS aspect_id
      , store.client_id                 AS client_id
      , SUM(turnover.val_rtl_net)       AS m1401
      
    FROM  p_lew_mart_msi_ac.v_agg_store_day_turnover_ext	      AS turnover
    
    INNER JOIN p_lew_mart_msi_ac.v_org_store_merge	            AS store
      ON  turnover.client_id = store.client_id 
      AND turnover.store_id = store.store_id
      
    INNER JOIN p_lew_mart_msi_ac.v_ref_currency	              AS currency
      ON 	turnover.client_id = currency.client_id 
      AND turnover.currency_iso_cd = currency.currency_iso_cd
      
    INNER JOIN p_lew_mart_msi_ac.v_cal_calendarday	            AS cal
      ON 	turnover.dat_formdate = cal.dat_calendar
      
    WHERE	cal.byr BETWEEN YEAR(CURRENT_DATE) -3 AND YEAR(CURRENT_DATE)
      AND store.aspect_id IN (1)
      AND currency.curr_tot_id = 0 
      AND currency.currency_iso_cd = 'eur'
      AND store.dashboard_relevant_fg = 1
      
    GROUP BY	
        cal.dat_calendar
      , store.move_to_store_id
      , store.aspect_id
      , store.client_id
  )

  , worktime_salespieces AS ( 
      SELECT	
        cal.dat_calendar                                                                      AS dat_calendar
      , store.move_to_store_id                                                                AS store_id
      , store.aspect_id                                                                       AS aspect_id
      , store.client_id                                                                       AS client_id
      , SUM(sp_p.sales_pieces)                                                                AS wjxbfs1
      , SUM(sp_p.work_time_total_hr)                                                          AS wjxbfs2
      , SUM((CASE WHEN cal.cy_day_sequence <=  0 THEN sp_p.sales_pieces ELSE NULL END))       AS wjxbfs3
      
      FROM	p_lew_mart_lead_ac.v_agg_store_day_sales_piece_perf	        AS sp_p

      INNER JOIN p_lew_mart_msi_ac.v_org_store_merge	      AS store
        ON  sp_p.client_id = store.client_id 
        AND sp_p.loc_sid_store = store.store_id

      INNER JOIN p_lew_mart_msi_ac.v_ref_currency          AS currency
        ON  sp_p.client_id = currency.client_id 
        AND sp_p.currency_iso_cd = currency.currency_iso_cd

      INNER JOIN p_lew_mart_msi_ac.v_cal_calendarday       AS cal
        ON  sp_p.dwh_cal_dt = cal.dat_calendar

      WHERE cal.byr BETWEEN YEAR(CURRENT_DATE) -3 AND YEAR(CURRENT_DATE)
        AND STORE.ASPECT_ID IN (1)
        AND currency.curr_tot_id = 0 
        AND currency.currency_iso_cd = 'eur'
        AND store.dashboard_relevant_fg = 1

      GROUP BY 
         cal.dat_calendar
        ,store.move_to_store_id
        ,store.aspect_id
        ,store.client_id
  )
    
  , turnover_worktime_salespieces AS (
    SELECT	
        COALESCE(turnover.dat_calendar, sp_p.dat_calendar)  AS dat_calendar
      , COALESCE(turnover.store_id, sp_p.store_id)          AS store_id
      , COALESCE(turnover.aspect_id, sp_p.aspect_id)        AS aspect_id
      , COALESCE(turnover.client_id, sp_p.client_id)        AS client_id
      , turnover.m1401                                      AS m1401
      , sp_p.wjxbfs1                                        AS wjxbfs1
      , sp_p.wjxbfs2                                        AS wjxbfs2
      
    FROM	turnover	                                  AS turnover

    FULL OUTER JOIN	worktime_salespieces	            AS sp_p
      ON  turnover.aspect_id = sp_p.aspect_id 
      AND turnover.client_id = sp_p.client_id 
      AND turnover.dat_calendar = sp_p.dat_calendar 
      AND turnover.store_id = sp_p.store_id
  )

SELECT	
    cal.byr                         AS byr
  , store.client_id                 AS client_id
  , store.country_iso_cd            AS client_desc
  , store.move_to_store_id          AS store_id
  , store.aspect_id                 AS aspect_id
  , store.orig_store_nr             AS orig_store_nr
  , cal.dat_calendar                AS dat_calendar1
  , cal.cy_month                    AS cy_month
  , MAX(tws.wjxbfs1)                AS wjxbfs1
  , MAX(tws.wjxbfs2)                AS wjxbfs3
  
FROM	turnover_worktime_salespieces	                                              AS tws

FULL OUTER JOIN	worktime_salespieces	                                            AS sp_p
  ON  tws.aspect_id = sp_p.aspect_id 
  AND	tws.client_id = sp_p.client_id 
  AND	tws.dat_calendar = sp_p.dat_calendar 
  AND tws.store_id = sp_p.store_id

INNER JOIN p_lew_mart_msi_ac.v_cal_calendarday	                      AS cal
  ON COALESCE(tws.dat_calendar, sp_p.dat_calendar) = cal.dat_calendar

INNER JOIN p_lew_mart_msi_ac.v_org_all_store_merge	                  AS store
  ON  COALESCE(tws.aspect_id, sp_p.aspect_id) = store.aspect_id 
  AND COALESCE(tws.client_id, sp_p.client_id) = store.client_id 
  AND COALESCE(tws.store_id, sp_p.store_id) = store.move_to_store_id

GROUP BY 
    cal.byr
  , store.client_id
  , store.country_iso_cd
  , store.move_to_store_id
  , store.aspect_id
  , store.orig_store_nr
  , cal.dat_calendar
  , cal.cy_month
);
/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_BW_CLEANEDUP_TURNOVER_YBL_2
#----------------------------------------------------------------------------
# History:
#  1.0  12.05.2023    Ulrich Ross               Init, User Story 476747
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_CS.V_BW_CLEANEDUP_TURNOVER_YBL_2(
  calmonth
 ,client_id  
 ,client_desc  
 ,currency_iso_cd   
 ,country_iso_cd
 ,turnover_lj_ber    -- umsatz lj bereinigt (auf basis des vvj)  
 ,turnover_vvj_ber   -- umsatz vvj bereinigt   
) 
AS( 
 WITH turnover_cy AS (
    SELECT	
       curr.currency_iso_cd           AS currency_iso_cd
      ,cal.cy_month                   AS cy_month
      ,curr.client_id                 AS client_id
      ,SUM(turnover.val_rtl_net)      AS m1402
      
    FROM	p_lew_mart_msi_ac.v_agg_store_day_turnover_ext_2	            AS turnover
    INNER JOIN	p_lew_mart_msi_ac.v_ref_currency_2	                    AS curr
      ON 	turnover.client_id = curr.client_id 
      AND turnover.currency_iso_cd = curr.currency_iso_cd
    INNER JOIN	p_lew_mart_msi_ac.v_org_store_merge_2	                  AS store
      ON 	turnover.client_id = store.client_id 
      AND turnover.store_id = store.store_id
    INNER JOIN	p_lew_mart_msi_ac.v_cal_calendarday_2	                  AS cal
      ON 	turnover.dat_formdate = cal.dat_calendar
    INNER JOIN	p_lew_mart_msi_ac.v_org_store_pre_2	                    AS store_pre
      ON 	turnover.client_id = store_pre.client_id 
      AND turnover.store_id = store_pre.store_id
    WHERE	((turnover.dat_formdate >=  store.dat_calc_start_ppy 
      AND store.move_fg = 1)
        OR turnover.dat_formdate BETWEEN store.dat_calc_start_ppy AND store.dat_calc_end_py
        OR (turnover.dat_formdate >=  store.dat_calc_start_ppy
      AND store_pre.dat_calc_end_ppy IS NULL))
      AND store.aspect_id = 1
      AND cal.cy_month BETWEEN TO_VARCHAR(DATEADD('YEAR', -6, CURRENT_DATE),'YYYYMM') AND TO_VARCHAR(CURRENT_DATE,'YYYYMM')
      AND store.dashboard_relevant_fg = 1
    GROUP BY	
       curr.currency_iso_cd
      ,cal.cy_month
      ,curr.client_id
  )

  ,turnover_ybl AS(
    SELECT	
       curr.currency_iso_cd               AS currency_iso_cd
      ,cal_month_ber.cy_month             AS cy_month
      ,curr.client_id                     AS client_id
      ,SUM(turnover.val_rtl_net)          AS m1402
      
    FROM	p_lew_mart_msi_ac.v_agg_store_day_turnover_ext_2	                  AS turnover
    INNER JOIN	p_lew_mart_msi_ac.v_cal_month_ber_2	                          AS cal_month_ber
      ON 	turnover.dat_formdate = cal_month_ber.dat_calendar_ppy
    INNER JOIN	p_lew_mart_msi_ac.v_ref_currency_2	                          AS curr
      ON 	turnover.client_id = curr.client_id 
      AND turnover.currency_iso_cd = curr.currency_iso_cd
    INNER JOIN	p_lew_mart_msi_ac.v_org_store_merge_2	                        AS store
      ON 	turnover.client_id = store.client_id 
      AND turnover.store_id = store.store_id
    INNER JOIN	p_lew_mart_msi_ac.v_cal_calendarday_2	                        AS cal
      ON 	cal_month_ber.dat_calendar_amd = cal.dat_calendar
    INNER JOIN	p_lew_mart_msi_ac.v_org_store_pre_2	                          AS store_pre
      ON 	turnover.client_id = store_pre.client_id 
      AND turnover.store_id = store_pre.store_id
    WHERE	((cal_month_ber.dat_calendar_amd >=  store.dat_calc_start_ppy
      AND store.move_fg = 1)
        OR cal_month_ber.dat_calendar_amd BETWEEN store.dat_calc_start_ppy AND store.dat_calc_end_py
        OR (cal_month_ber.dat_calendar_amd >=  store.dat_calc_start_ppy
      AND store_pre.dat_calc_end_ppy IS NULL))
      AND cal.cy_day_sequence <=  0
      AND store.aspect_id = 1
      AND cal_month_ber.cy_month BETWEEN TO_VARCHAR(DATEADD('YEAR', -6, CURRENT_DATE),'YYYYMM') AND TO_VARCHAR(CURRENT_DATE,'YYYYMM')
      AND store.dashboard_relevant_fg = 1
    GROUP BY	
       curr.currency_iso_cd
      ,cal_month_ber.cy_month
      ,curr.client_id
  )

  SELECT
     TRIM(COALESCE(turnover_cy.cy_month, turnover_ybl.cy_month))                  AS calmonth
    ,COALESCE(turnover_cy.client_id, turnover_ybl.client_id)                      AS client_id
    ,MAX(CLIENT.country_desc)                                                     AS client_desc
    ,COALESCE(turnover_cy.currency_iso_cd, turnover_ybl.currency_iso_cd)          AS currency_iso_cd
    ,MAX(CLIENT.country_iso_cd)                                                   AS country_iso_cd
    ,MAX(turnover_cy.m1402)                                                       AS turnover_lj_ber    -- umsatz lj bereinigt (auf basis des vvj)
    ,MAX(turnover_ybl.m1402)                                                      AS turnover_vvj_ber   -- umsatz vvj bereinigt 
    
  FROM	turnover_cy	                                                                                AS turnover_cy
  FULL OUTER JOIN	turnover_ybl	                                                                    AS turnover_ybl
    ON 	turnover_cy.client_id = turnover_ybl.client_id
    AND turnover_cy.currency_iso_cd = turnover_ybl.currency_iso_cd
    AND turnover_cy.cy_month = turnover_ybl.cy_month
  INNER JOIN	p_lew_mart_msi_ac.v_ref_client_lead_2	                                                  AS CLIENT
    ON 	COALESCE(turnover_cy.client_id, turnover_ybl.client_id) = CLIENT.client_id
  GROUP BY
     COALESCE(turnover_cy.cy_month, turnover_ybl.cy_month)
    ,COALESCE(turnover_cy.currency_iso_cd, turnover_ybl.currency_iso_cd)
    ,COALESCE(turnover_cy.client_id, turnover_ybl.client_id)
);
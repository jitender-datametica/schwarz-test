/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_BW_CLEANEDUP_TURNOVER_CUSTOMER_LY_2
#----------------------------------------------------------------------------
# History:
#  1.0  12.05.2023    Ulrich Ross               Init, User Story 476747
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_CS.V_BW_CLEANEDUP_TURNOVER_CUSTOMER_LY_2(
   calmonth
  ,client_id
  ,client_desc
  ,currency_iso_cd      
  ,country_iso_cd
  ,ber_kund_in_proz  
  ,ber_umsatz_in_proz 
  ,turnover_lj_ber        -- bereinigter umsatz lj (auf basis vj)
  ,turnover_vj_ber        -- bereinigter umsatz vj
  ,turnover_vj_ber_netto  -- bereinigter umsatz netto vj 
  ,customer_lj_ber        -- kundenanzahl bereinigt
  ,customer_vj_ber        -- kundenanzahl bereinigt vj    
) 
AS(
  WITH turnover_ber AS (
    SELECT	
       curr.currency_iso_cd                                AS currency_iso_cd
      ,cal.cy_month                                        AS cy_month
      ,store.client_id                                     AS client_id
      ,SUM(turnover.val_rtl_net * turnover.bereinigt_fg)   AS m1401
      
    FROM	p_lew_mart_msi_ac.v_agg_store_day_turnover_ext_2	    AS turnover
    INNER JOIN	p_lew_mart_msi_ac.v_org_store_merge_2	          AS store
      ON 	turnover.client_id = store.client_id 
      AND turnover.store_id = store.store_id
    INNER JOIN	p_lew_mart_msi_ac.v_cal_calendarday_2	          AS cal
      ON 	turnover.dat_formdate = cal.dat_calendar
    INNER JOIN	p_lew_mart_msi_ac.v_ref_currency_2	            AS curr
      ON 	turnover.client_id = curr.client_id 
      AND turnover.currency_iso_cd = curr.currency_iso_cd
    WHERE	store.aspect_id = 1
      AND cal.cy_month BETWEEN TO_VARCHAR(DATEADD('YEAR', -6, CURRENT_DATE),'YYYYMM') AND TO_VARCHAR(CURRENT_DATE,'YYYYMM')
      AND store.dashboard_relevant_fg = 1
    GROUP BY 
       curr.currency_iso_cd
      ,cal.cy_month
      ,store.client_id
  )
   
  , customer_ber AS (
    SELECT	
       curr.currency_iso_cd                                     AS currency_iso_cd
      ,cal.cy_month                                             AS cy_month
      ,store.client_id                                          AS client_id
      ,SUM(customer.cnt_customer_asis * turnover.bereinigt_fg)  AS m1404
      
    FROM	p_lew_mart_msi_ac.v_agg_store_day_turnover_ext_2	          AS turnover
    INNER JOIN	p_lew_mart_msi_ac.v_agg_str_day_ejr_txj_ww_ext_2	    AS customer
      ON 	turnover.client_id = customer.client_id 
      AND turnover.currency_iso_cd = customer.currency_iso_cd 
      AND turnover.dat_formdate = customer.dat_formdate 
      AND turnover.store_id = customer.store_id
    INNER JOIN	p_lew_mart_msi_ac.v_org_store_merge_2	                AS store
      ON 	turnover.client_id = store.client_id 
      AND turnover.store_id = store.store_id
    INNER JOIN	p_lew_mart_msi_ac.v_cal_calendarday_2	                AS cal
      ON 	turnover.dat_formdate = cal.dat_calendar
    INNER JOIN	p_lew_mart_msi_ac.v_ref_currency_2	                  AS curr
      ON 	turnover.client_id = curr.client_id 
      AND turnover.currency_iso_cd = curr.currency_iso_cd
    WHERE	store.aspect_id = 1
      AND cal.cy_month BETWEEN TO_VARCHAR(DATEADD('YEAR', -6, CURRENT_DATE),'YYYYMM') AND TO_VARCHAR(CURRENT_DATE,'YYYYMM')
      AND store.dashboard_relevant_fg = 1
    GROUP BY	
       curr.currency_iso_cd
      ,cal.cy_month
      ,store.client_id
  )

  , umsatz_customer_ly_ber AS (
    SELECT	
       curr.currency_iso_cd                                                   AS currency_iso_cd
      ,cal_month_ber.cy_month                                                 AS cy_month
      ,store.client_id                                                        AS client_id
      ,SUM(customer.cnt_customer_asis * turnover.bereinigt_vjm_fg)            AS m1404
      ,SUM(turnover.val_rtl_net * turnover.bereinigt_vjm_fg)                  AS m1401
      
    FROM	p_lew_mart_msi_ac.v_agg_store_day_turnover_ext_2	          AS turnover
    INNER JOIN	p_lew_mart_msi_ac.v_agg_str_day_ejr_txj_ww_ext_2	    AS customer
      ON turnover.client_id = customer.client_id 
      AND turnover.currency_iso_cd = customer.currency_iso_cd 
      AND turnover.dat_formdate = customer.dat_formdate 
      AND turnover.store_id = customer.store_id
    INNER JOIN	p_lew_mart_msi_ac.v_cal_month_ber_2	                  AS cal_month_ber
      ON turnover.dat_formdate = cal_month_ber.dat_calendar_pyd
    INNER JOIN	p_lew_mart_msi_ac.v_org_store_merge_2	                AS store
      ON turnover.client_id = store.client_id 
      AND turnover.store_id = store.store_id
    INNER JOIN	p_lew_mart_msi_ac.v_ref_currency_2	                  AS curr
      ON turnover.client_id = curr.client_id 
      AND turnover.currency_iso_cd = curr.currency_iso_cd
    INNER JOIN	p_lew_mart_msi_ac.v_cal_calendarday_2	                AS cal
      ON cal_month_ber.dat_calendar_amd = cal.dat_calendar
    WHERE	cal.cy_day_sequence <=  0
      AND store.aspect_id = 1
      AND cal.cy_month BETWEEN TO_VARCHAR(DATEADD('YEAR', -6, CURRENT_DATE),'YYYYMM') AND TO_VARCHAR(CURRENT_DATE,'YYYYMM')
      AND store.dashboard_relevant_fg = 1
    GROUP BY	
       curr.currency_iso_cd
      ,cal_month_ber.cy_month
      ,store.client_id
  )

  , turnover_ly AS (
    SELECT
       curr.currency_iso_cd                                             AS currency_iso_cd
      ,cal_month_ber.cy_month                                           AS cy_month
      ,curr.client_id                                                   AS client_id
      ,SUM(turnover.val_rtl_net)                                        AS m1402
      
    FROM	p_lew_mart_msi_ac.v_agg_store_day_turnover_ext_2	              AS turnover
    INNER JOIN	p_lew_mart_msi_ac.v_cal_month_ber_2	                      AS cal_month_ber
      ON 	turnover.dat_formdate = cal_month_ber.dat_calendar_pyd
    INNER JOIN	p_lew_mart_msi_ac.v_ref_currency_2	                      AS curr
      ON 	turnover.client_id = curr.client_id 
      AND turnover.currency_iso_cd = curr.currency_iso_cd
    INNER JOIN	p_lew_mart_msi_ac.v_org_store_merge_2	                    AS store
      ON 	turnover.client_id = store.client_id 
      AND turnover.store_id = store.store_id
    INNER JOIN	p_lew_mart_msi_ac.v_cal_calendarday_2	                    AS cal
      ON 	cal_month_ber.dat_calendar_amd = cal.dat_calendar
    WHERE	((cal_month_ber.dat_calendar_amd >=  store.dat_calc_start_py
      AND store.move_fg = 1)
        OR cal_month_ber.dat_calendar_amd BETWEEN store.dat_calc_start_py AND store.dat_calc_end_py
        OR (cal_month_ber.dat_calendar_amd >=  store.dat_calc_start_py
            AND store.dat_calc_end_py IS NULL))
     AND cal.cy_day_sequence <=  0
     AND store.aspect_id = 1
     AND cal.cy_month BETWEEN TO_VARCHAR(DATEADD('YEAR', -6, CURRENT_DATE),'YYYYMM') AND TO_VARCHAR(CURRENT_DATE,'YYYYMM')
     AND store.dashboard_relevant_fg = 1
    GROUP BY	
       curr.currency_iso_cd
      ,cal_month_ber.cy_month
      ,curr.client_id
    )


    SELECT	
       TRIM(COALESCE(turnbe.cy_month, cust_be.cy_month, cust_ly_be.cy_month, turn_ly.cy_month))                       AS calmonth
      ,COALESCE(turnbe.client_id, cust_be.client_id, cust_ly_be.client_id, turn_ly.client_id)                         AS client_id
      ,MAX(client_lead.country_desc)                                                                                  AS client_desc
      ,COALESCE(turnbe.currency_iso_cd, cust_be.currency_iso_cd, cust_ly_be.currency_iso_cd, turn_ly.currency_iso_cd) AS currency_iso_cd
      ,MAX(client_lead.country_iso_cd)                                                                                AS country_iso_cd
      ,DIV0(MAX(cust_be.m1404) - MAX(cust_ly_be.m1404), MAX(cust_ly_be.m1404) * 100)                                  AS ber_kund_in_proz
      ,DIV0(MAX(turnbe.m1401) - MAX(turn_ly.m1402), MAX(turn_ly.m1402) * 100)                                         AS ber_umsatz_in_proz
      ,MAX(turnbe.m1401)                                                                                              AS turnover_lj_ber        -- bereinigter umsatz lj (auf basis vj)
      ,MAX(cust_ly_be.m1401)                                                                                          AS turnover_vj_ber        -- bereinigter umsatz vj
      ,MAX(turn_ly.m1402)                                                                                             AS turnover_vj_ber_netto  -- bereinigter umsatz netto vj 
      ,MAX(cust_be.m1404)                                                                                             AS customer_lj_ber        -- kundenanzahl bereinigt
      ,MAX(cust_ly_be.m1404)                                                                                          AS customer_vj_ber        -- kundenanzahl bereinigt vj
    
    FROM	turnover_ber	                                                                                                      AS turnbe
    FULL OUTER JOIN	customer_ber	                                                                                            AS cust_be
      ON  turnbe.client_id = cust_be.client_id 
      AND turnbe.currency_iso_cd = cust_be.currency_iso_cd
      AND turnbe.cy_month = cust_be.cy_month
    FULL OUTER JOIN	umsatz_customer_ly_ber	                                                                                  AS cust_ly_be
      ON  COALESCE(turnbe.client_id, cust_be.client_id) = cust_ly_be.client_id 
      AND COALESCE(turnbe.currency_iso_cd, cust_be.currency_iso_cd) = cust_ly_be.currency_iso_cd
      AND COALESCE(turnbe.cy_month, cust_be.cy_month) = cust_ly_be.cy_month
    FULL OUTER JOIN	turnover_ly	                                                                                              AS turn_ly
      ON 	COALESCE(turnbe.client_id, cust_be.client_id, cust_ly_be.client_id) = turn_ly.client_id 
      AND COALESCE(turnbe.currency_iso_cd, cust_be.currency_iso_cd, cust_ly_be.currency_iso_cd) = turn_ly.currency_iso_cd
      AND COALESCE(turnbe.cy_month, cust_be.cy_month, cust_ly_be.cy_month) = turn_ly.cy_month
    INNER JOIN	p_lew_mart_msi_ac.v_ref_client_lead_2	                                                                          AS client_lead
      ON 	COALESCE(turnbe.client_id, cust_be.client_id, cust_ly_be.client_id, turn_ly.client_id) = client_lead.client_id
    GROUP BY	
       COALESCE(turnbe.cy_month, cust_be.cy_month, cust_ly_be.cy_month, turn_ly.cy_month)
      ,COALESCE(turnbe.currency_iso_cd, cust_be.currency_iso_cd, cust_ly_be.currency_iso_cd, turn_ly.currency_iso_cd)
      ,COALESCE(turnbe.client_id, cust_be.client_id, cust_ly_be.client_id, turn_ly.client_id)
);


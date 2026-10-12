/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_BW_LP_OHNE_COUPON_1
#----------------------------------------------------------------------------
# History:
#  1.0  30.08.2023    Ulrich Ross               Init
#                                               User Story 501418
#  1.1  02.10.2023    Ulrich Ross               Add DIV0
#                                               User Story 532588
#                                             
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_CS.V_BW_LP_OHNE_COUPON_1
(
    client_id
  , country_iso_cd
  , client_desc
  , cy_month
  , cy_month_name
  , YEAR
  , new_cust
  , lp_cust_discval
  , non_lp_cust_discval
  , discval_all
  , all_num_recp
  , cm_dereg_cnt
  , new_cust_per_country
  , lp_total_net_val
  , download_cnt
  , non_lp_total_net_val
  , store_cnt
  , cm_reg_cnt
  , non_lp_num_recp
  , lp_cust_recp
  , cm_total_new_reg_cnt
  , reg_cust
  , all_total_net_val
  , lp_num_recp
  , lp_pricechange_disc_perc
  , non_lp_pricechange_disc_perc
  , all_pricechange_disc_perc
  , lp_pricechange_ejr_perc
  , lp_active_cust
  , lp_revenue_share_perc  
  , lp_bon_id_rate
  , lp_buying_freq
  , lp_revnue_per_cust
  , lp_avg_bon
  , non_lp_avg_bon
  , all_avg_bon    
 )
AS

WITH  lp_cust AS ( 
  SELECT	
      cal.cy_month                                                                AS cy_month
    , r_cl.client_id                                                              AS client_id
    , CASE WHEN COUNT(DISTINCT lp_rcpt.customer_sid) = 0 
        THEN NULL 
        ELSE COUNT(DISTINCT lp_rcpt.customer_sid) 
        END                                                                       AS new_cust  
    , COUNT(DISTINCT lp_rcpt.customer_sid)                                        AS new_cust_per_country  
    , COUNT(DISTINCT lp_rcpt.customer_sid)                                        AS reg_cust  
    
  FROM	p_lew_mart_lidl_digital_ac.v_agg_rcpt_hdr_ldpl_day_1	        AS lp_rcpt
  
  INNER JOIN	p_lew_mart_msi_ac.v_cal_calendarday_1	    AS cal
    ON 	lp_rcpt.dwh_cal_dt = cal.dat_calendar
    
  INNER JOIN	p_lew_mart_msi_ac.v_ref_client_lead_1	                  AS r_cl
    ON 	lp_rcpt.client_id = r_cl.client_id
    
  INNER JOIN	p_lew_mart_msi_ac.v_ref_currency_1	                    AS curr
    ON 	lp_rcpt.client_id = curr.client_id 
    AND lp_rcpt.curr_tot_id = curr.curr_tot_id
    AND curr.curr_tot_id = 0     
    
  WHERE	lp_rcpt.lidlplus_cust_fg = 'Y'
    AND lp_rcpt.aspect_id = 2
    AND cal.cy_month IN ( SELECT DISTINCT cy_month 
                          FROM p_lew_mart_msi_ac.v_cal_calendarday_1
                          WHERE byr = ( SELECT  byr 
                                        FROM p_lew_mart_msi_ac.v_cal_calendarday_1
                                        WHERE dat_calendar = CURRENT_DATE - 1
                                      )
                        )
    AND r_cl.dashboard_relevant_fg = 1
  GROUP BY	
      cal.cy_month
    , r_cl.client_id
)

, lp_recp AS ( 
  SELECT	
      cal.cy_month                                            AS cy_month
    , r_cl.client_id                                          AS client_id
    , SUM ( CASE WHEN client_rcpt.lidlplus_cust_fg = 'Y'
              THEN client_rcpt.number_of_receipts 
              ELSE NULL 
            END)                                              AS lp_cust_recp 
    , SUM (client_rcpt.number_of_receipts )                   AS all_num_recp 
    , SUM (client_rcpt.total_net_val)                         AS all_total_net_val 
    , SUM ( CASE WHEN client_rcpt.lidlplus_cust_fg = 'Y' 
              THEN client_rcpt.total_net_val
              ELSE NULL 
            END)                                              AS lp_total_net_val
    , SUM ( CASE WHEN client_rcpt.lidlplus_cust_fg = 'Y' 
              THEN client_rcpt.number_of_receipts
              ELSE NULL 
            END)                                              AS lp_num_recp
    , SUM ( CASE WHEN client_rcpt.lidlplus_cust_fg = 'N' 
              THEN client_rcpt.total_net_val 
              ELSE NULL 
            END)                                              AS non_lp_total_net_val 
    , SUM ( CASE WHEN client_rcpt.lidlplus_cust_fg = 'N' 
              THEN client_rcpt.number_of_receipts 
              ELSE NULL 
            END)                                              AS non_lp_num_recp 

  FROM	p_lew_mart_lidl_digital_ac.v_agg_client_rcpt_hdr_ldpl_day_1	AS client_rcpt
  
  INNER JOIN	p_lew_mart_msi_ac.v_cal_calendarday_1	  AS cal
    ON 	client_rcpt.dwh_cal_dt = cal.dat_calendar
    
  INNER JOIN	p_lew_mart_msi_ac.v_ref_client_lead_1	                AS r_cl
    ON 	client_rcpt.client_id = r_cl.client_id
    
  INNER JOIN	p_lew_mart_msi_ac.v_ref_currency_1	                  AS curr
    ON 	client_rcpt.client_id = curr.client_id 
    AND client_rcpt.curr_tot_id = curr.curr_tot_id
    AND curr.curr_tot_id = 0     

      
  WHERE	client_rcpt.aspect_id = 2
    AND cal.cy_month IN ( SELECT DISTINCT cy_month 
                          FROM p_lew_mart_msi_ac.v_cal_calendarday_1
                          WHERE byr = ( SELECT  byr 
                                        FROM p_lew_mart_msi_ac.v_cal_calendarday_1
                                        WHERE dat_calendar = CURRENT_DATE - 1
                                      )
                        )
    AND r_cl.dashboard_relevant_fg = 1
  GROUP BY	
      cal.cy_month
    , r_cl.client_id
)

, lp_cust_all AS (
  SELECT	
      COALESCE(lp_cust.cy_month, lp_recp.cy_month)      AS cy_month
    , COALESCE(lp_cust.client_id, lp_recp.client_id)    AS client_id
    , lp_cust.new_cust                                  AS new_cust
    , lp_cust.new_cust_per_country                      AS new_cust_per_country
    , lp_recp.lp_cust_recp                              AS lp_cust_recp
    , lp_cust.reg_cust                                  AS reg_cust
    
  FROM	lp_cust	                                AS lp_cust
  FULL OUTER JOIN	lp_recp	                      AS lp_recp
    ON 	lp_cust.client_id = lp_recp.client_id 
    AND lp_cust.cy_month = lp_recp.cy_month
)

, lp_recp_disc AS (
  SELECT	
      cal.cy_month  cy_month
    , r_cl.client_id                                                  AS client_id
    , SUM ( CASE WHEN lp_rcpt.lidlplus_cust_fg = 'Y' 
              THEN lp_rcpt.discount_val 
              ELSE NULL 
            END)                                                      AS lp_cust_discval
    , SUM ( CASE WHEN lp_rcpt.lidlplus_cust_fg = 'N' 
              THEN lp_rcpt.discount_val 
              ELSE NULL
            END)                                                      AS non_lp_cust_discval
    , SUM (lp_rcpt.discount_val)                                      AS discval_all
    
  FROM	p_lew_mart_lidl_digital_ac.v_agg_rcpt_hdr_ldpl_day_1	          AS lp_rcpt

  INNER JOIN	p_lew_mart_msi_ac.v_cal_calendarday_1	      AS cal
    ON 	lp_rcpt.dwh_cal_dt = cal.dat_calendar
    
  INNER JOIN	p_lew_mart_msi_ac.v_ref_client_lead_1	                    AS r_cl
    ON 	lp_rcpt.client_id = r_cl.client_id

  INNER JOIN	p_lew_mart_msi_ac.v_ref_currency_1	                      AS curr
    ON 	lp_rcpt.client_id = curr.client_id 
    AND lp_rcpt.curr_tot_id = curr.curr_tot_id
    AND curr.curr_tot_id = 0
      
  WHERE	lp_rcpt.aspect_id = 2
    AND cal.cy_month IN ( SELECT DISTINCT cy_month 
                          FROM p_lew_mart_msi_ac.v_cal_calendarday_1
                          WHERE byr = ( SELECT  byr 
                                        FROM p_lew_mart_msi_ac.v_cal_calendarday_1
                                        WHERE dat_calendar = CURRENT_DATE - 1
                                      )
                        )
    AND r_cl.dashboard_relevant_fg = 1
  GROUP BY	
      cal.cy_month
    , r_cl.client_id
)

, lp_cust_reg_dereg AS (
  SELECT	
      lp_crd.cy_month                     AS cy_month
    , r_cl.client_id                      AS client_id
    , SUM (lp_crd.cm_dereg_cnt)           AS cm_dereg_cnt
    , SUM (lp_crd.cm_reg_cnt)             AS cm_reg_cnt
    , SUM (lp_crd.cm_total_new_reg_cnt)   AS cm_total_new_reg_cnt
    
  FROM	p_lew_mart_lidl_digital_ac.v_agg_cust_reg_dereg_ldpl_mth_1	AS lp_crd
  
  INNER JOIN	p_lew_mart_msi_ac.v_ref_client_lead_1	                AS r_cl
  ON 	lp_crd.client_id = r_cl.client_id
  
  WHERE lp_crd.cy_month IN (  SELECT DISTINCT cy_month 
                              FROM p_lew_mart_msi_ac.v_cal_calendarday_1
                              WHERE byr = ( SELECT  byr 
                                            FROM p_lew_mart_msi_ac.v_cal_calendarday_1
                                            WHERE dat_calendar = CURRENT_DATE - 1
                                          )
                            )
    --AND r_cl.client_id IN (4)
  AND r_cl.dashboard_relevant_fg = 1
  GROUP BY
      lp_crd.cy_month
    , r_cl.client_id
)

, ld_dwnload AS (
  SELECT	
      cal.cy_month                                              AS cy_month
    , r_cl.client_id                                            As client_id
    , SUM(lp_app_store.download_cnt)                            AS download_cnt
    
  FROM	p_lew_mart_lidl_digital_ac.v_agg_app_store_ldpl_day_1	                  AS lp_app_store
  
  INNER JOIN	p_lew_mart_msi_ac.v_cal_calendarday_1	              AS cal
    ON lp_app_store.dwh_cal_dt = cal.dat_calendar
    
  INNER JOIN	p_lew_mart_msi_ac.v_ref_client_lead_1	                            AS r_cl
    ON lp_app_store.client_id = r_cl.client_id
    
  WHERE	r_cl.client_id IN (SELECT	r_region.client_id
                          FROM	p_lew_mart_msi_ac.v_ref_aspect_1	  AS r_asp
                          INNER JOIN	p_lew_mart_msi_ac.v_ref_gl_region_merge_1	AS r_region
                            ON r_asp.aspect_id = r_region.aspect_id
                          WHERE	r_asp.aspect_id = 2
                          GROUP BY r_region.client_id
                          ) 
    AND r_cl.dashboard_relevant_fg = 1
    AND cal.cy_month IN ( SELECT DISTINCT cy_month 
                          FROM p_lew_mart_msi_ac.v_cal_calendarday_1
                          WHERE byr = ( SELECT  byr 
                                        FROM p_lew_mart_msi_ac.v_cal_calendarday_1
                                        WHERE dat_calendar = CURRENT_DATE - 1
                                      )
                        )
  GROUP BY	
      cal.cy_month
    , r_cl.client_id
)

, store_per_client AS (
  SELECT	
      som.cy_month                                                  AS cy_month
    , r_cl.client_id                                                AS client_id
    , COUNT(DISTINCT som.client_id || '_' || som.move_to_store_id)  AS store_cnt
    
  FROM	p_lew_mart_lidl_digital_ac.v_store_open_month_1	    AS som
  
  INNER JOIN	p_lew_mart_msi_ac.v_ref_client_lead_1	        AS r_cl
    ON som.client_id = r_cl.client_id
    
  WHERE	som.cm_mth_ending_str_open_fg = 1
    AND som.aspect_id = 2
    --AND r_cl.client_id IN (4)
    AND r_cl.dashboard_relevant_fg = 1
    AND som.cy_month IN ( SELECT DISTINCT cy_month 
                          FROM p_lew_mart_msi_ac.v_cal_calendarday_1
                          WHERE byr = ( SELECT  byr 
                                        FROM p_lew_mart_msi_ac.v_cal_calendarday_1
                                        WHERE dat_calendar = CURRENT_DATE - 1
                                      )
                        )
  GROUP BY	
      som.cy_month
    , r_cl.client_id
)

SELECT	
    r_cl.client_id                              AS client_id
	, r_cl.country_iso_cd                         AS country_iso_cd
	, r_cl.country_desc                           AS client_desc
	, cmd.cy_month                                AS cy_month
	, cmd.cy_month_name                           AS cy_month_name
  , cmd.byr                                     AS YEAR
	, MAX(lp_cust_all.new_cust)                   AS new_cust
	, MAX(lp_recp_disc.lp_cust_discval)           AS lp_cust_discval
	, MAX(lp_recp_disc.non_lp_cust_discval)       AS non_lp_cust_discval
	, MAX(lp_recp_disc.discval_all)               AS discval_all
	, MAX(lp_recp.all_num_recp)                   AS all_num_recp
	, MAX(lp_cust_reg_dereg.cm_dereg_cnt)         AS cm_dereg_cnt
	, MAX(lp_cust_all.new_cust_per_country)       AS new_cust_per_country
	, MAX(lp_recp.lp_total_net_val)               AS lp_total_net_val
	, MAX(ld_dwnload.download_cnt)                AS download_cnt
	, MAX(lp_recp.non_lp_total_net_val)           AS non_lp_total_net_val
	, MAX(store_per_client.store_cnt)             AS store_cnt
	, MAX(lp_cust_reg_dereg.cm_reg_cnt)           AS cm_reg_cnt
	, MAX(lp_recp.non_lp_num_recp)                AS non_lp_num_recp
	, MAX(lp_cust_all.lp_cust_recp)               AS lp_cust_recp
	, MAX(lp_cust_reg_dereg.cm_total_new_reg_cnt) AS cm_total_new_reg_cnt
	, MAX(lp_cust_all.reg_cust)                   AS reg_cust
	, MAX(lp_recp.all_total_net_val)              AS all_total_net_val
	, MAX(lp_recp.lp_num_recp)                    AS lp_num_recp
  , ROUND(DIV0(MAX(lp_recp_disc.lp_cust_discval), MAX(lp_recp.all_total_net_val))*100,3)                       AS lp_pricechange_disc_perc
  , ROUND(DIV0(MAX(lp_recp_disc.non_lp_cust_discval), MAX(lp_recp.all_total_net_val))*100,3)                   AS non_lp_pricechange_disc_perc  
  , ROUND(DIV0(MAX(lp_recp_disc.discval_all), MAX(lp_recp.all_total_net_val))*100,3)                           AS all_pricechange_disc_perc
  , ROUND(DIV0(MAX(lp_recp_disc.lp_cust_discval), MAX(lp_recp.lp_total_net_val))*100,3)                        AS lp_pricechange_ejr_perc
  , ROUND(DIV0(MAX(lp_cust_all.new_cust_per_country), MAX(lp_cust_reg_dereg.cm_total_new_reg_cnt))*100,3)      AS lp_active_cust
  , ROUND(DIV0(MAX(lp_recp.lp_total_net_val), MAX(lp_recp.all_total_net_val))*100,3)                           AS lp_revenue_share_perc
  , ROUND(DIV0(MAX(lp_recp.lp_num_recp), MAX(lp_recp.all_num_recp))*100,3)                                     AS lp_bon_id_rate
  , ROUND(DIV0(MAX(lp_recp.lp_num_recp), MAX(lp_cust_all.reg_cust)),3)                                     AS lp_buying_freq
  , ROUND(DIV0(MAX(lp_recp.lp_total_net_val), MAX(lp_cust_all.reg_cust)),3)                                AS lp_revnue_per_cust
  , ROUND(DIV0(MAX(lp_recp.lp_total_net_val), MAX(lp_recp.lp_num_recp)),3)                                 AS lp_avg_bon
  , ROUND(DIV0(MAX(lp_recp.non_lp_total_net_val), MAX(lp_recp.non_lp_num_recp)),3)                         AS non_lp_avg_bon    
  , ROUND(DIV0((MAX(lp_recp.lp_total_net_val)+MAX(non_lp_total_net_val))
          , (MAX(lp_recp.lp_num_recp)+MAX(lp_recp.non_lp_num_recp))),3)                      AS all_avg_bon 

FROM	lp_cust_all	lp_cust_all

FULL OUTER JOIN	lp_recp_disc	lp_recp_disc
  ON 	lp_cust_all.client_id = lp_recp_disc.client_id 
  AND lp_cust_all.cy_month = lp_recp_disc.cy_month
  
FULL OUTER JOIN	lp_recp	                                    AS lp_recp
  ON 	COALESCE(lp_cust_all.client_id, lp_recp_disc.client_id) = lp_recp.client_id 
  AND COALESCE(lp_cust_all.cy_month, lp_recp_disc.cy_month) = lp_recp.cy_month
  
FULL OUTER JOIN	lp_cust_reg_dereg	                          AS lp_cust_reg_dereg
  ON 	COALESCE(lp_cust_all.client_id, lp_recp_disc.client_id, lp_recp.client_id) = lp_cust_reg_dereg.client_id 
  AND COALESCE(lp_cust_all.cy_month, lp_recp_disc.cy_month, lp_recp.cy_month) = lp_cust_reg_dereg.cy_month
  
FULL OUTER JOIN	ld_dwnload	                                AS ld_dwnload
  ON 	COALESCE(lp_cust_all.client_id, lp_recp_disc.client_id, lp_recp.client_id, lp_cust_reg_dereg.client_id) = ld_dwnload.client_id 
  AND COALESCE(lp_cust_all.cy_month, lp_recp_disc.cy_month, lp_recp.cy_month, lp_cust_reg_dereg.cy_month) = ld_dwnload.cy_month
  
FULL OUTER JOIN	store_per_client	                          AS store_per_client
  ON 	COALESCE(lp_cust_all.client_id, lp_recp_disc.client_id, lp_recp.client_id, lp_cust_reg_dereg.client_id, ld_dwnload.client_id) = store_per_client.client_id 
  AND COALESCE(lp_cust_all.cy_month, lp_recp_disc.cy_month, lp_recp.cy_month, lp_cust_reg_dereg.cy_month, ld_dwnload.cy_month) = store_per_client.cy_month
  
INNER JOIN	p_lew_mart_msi_ac.v_ref_client_lead_1	            AS r_cl  
  ON 	COALESCE(lp_cust_all.client_id, lp_recp_disc.client_id, lp_recp.client_id, lp_cust_reg_dereg.client_id, ld_dwnload.client_id, store_per_client.client_id) = r_cl.client_id
  
INNER JOIN	p_lew_mart_msi_ac.v_cal_month_desc_1	AS cmd
  ON 	COALESCE(lp_cust_all.cy_month, lp_recp_disc.cy_month, lp_recp.cy_month, lp_cust_reg_dereg.cy_month, ld_dwnload.cy_month, store_per_client.cy_month) = cmd.cy_month
  
GROUP BY	
    r_cl.client_id
	, r_cl.country_desc
	, r_cl.country_iso_cd
	, cmd.cy_month
	, cmd.cy_month_name
  , cmd.byr
  ;
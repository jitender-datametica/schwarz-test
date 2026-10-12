/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_BW_LP_MIT_COUPON_2
#----------------------------------------------------------------------------
# History:
#  1.0  30.08.2023    Ulrich Ross               Init
#                                               User Story 501418
#  1.1  02.10.2023    Ulrich Ross               Add DIV0
#                                               User Story 532827
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_CS.V_BW_LP_MIT_COUPON_2
(
    client_id
  , client_desc
  , cy_month
  , cy_month_name
  , YEAR
  , coupon_type_id
  , coupon_type_desc
  , coupon_type_group_id
  , coupon_type_group_desc
  , coupon_type_subgroup_id
  , coupon_type_subgroup_desc
  , count_receipt    
  , cnt_cust 
  , discount_val 
  , discount_pct 
 )
 AS
WITH lp_cr AS (
  SELECT	
      ldpl_day.cy_month                                     AS cy_month
    , r_cl.client_id                                        AS client_id
    , ldpl_day.coupon_type_id                               AS coupon_type_id
    , COUNT(DISTINCT ldpl_day.receipt_total_net_val_uniq)   AS count_receipt
    
  FROM	p_lew_mart_lidl_digital_ac.v_agg_rcpt_coupon_promo_discount_ldpl_day_2	AS ldpl_day
  
  INNER JOIN	p_lew_mart_msi_ac.v_ref_client_lead_2	                            AS r_cl
    ON 	ldpl_day.client_id = r_cl.client_id
    
  INNER JOIN	p_lew_mart_msi_ac.v_ref_currency_2	                              AS curr
    ON 	ldpl_day.client_id = curr.client_id 
    AND ldpl_day.curr_tot_id = curr.curr_tot_id
    AND curr.curr_tot_id = 0 
                        
  WHERE	ldpl_day.lidlplus_cust_fg = 'Y'
    AND ldpl_day.aspect_id = 2
    AND r_cl.dashboard_relevant_fg = 1
    AND ldpl_day.cy_month IN ( SELECT DISTINCT cy_month 
                               FROM p_lew_mart_msi_ac.v_cal_calendarday_2
                               WHERE byr = ( SELECT  byr 
                                             FROM p_lew_mart_msi_ac.v_cal_calendarday_2
                                             WHERE dat_calendar = CURRENT_DATE - 1
                                            )
                              )
  GROUP BY	
      ldpl_day.cy_month
    , r_cl.client_id
    , ldpl_day.coupon_type_id
)

, lp_dv AS (
  SELECT	
      lp_discount.cy_month                                                                                AS cy_month
    , r_cl.client_id                                                                                      AS client_id
    , lp_discount.coupon_type_id                                                                          AS coupon_type_id
    , (CASE WHEN SUM(lp_discount.cm_discount_val)=0 THEN NULL ELSE SUM(lp_discount.cm_discount_val) END)  AS discount_val
    
  FROM	p_lew_mart_lidl_digital_ac.v_agg_unq_cust_coupon_promo_discount_ldpl_mth_2	AS lp_discount

  INNER JOIN	p_lew_mart_msi_ac.v_ref_client_lead_2	                                AS r_cl
    ON lp_discount.client_id = r_cl.client_id

  INNER JOIN	p_lew_mart_msi_ac.v_ref_currency_2	                                  AS curr
    ON 	lp_discount.client_id = curr.client_id 
    AND lp_discount.curr_tot_id = curr.curr_tot_id
    AND curr.curr_tot_id = 0

  WHERE	lp_discount.lidlplus_cust_fg = 'Y'
    AND lp_discount.aspect_id = 2
    AND lp_discount.cy_month IN ( SELECT DISTINCT cy_month 
                                  FROM p_lew_mart_msi_ac.v_cal_calendarday_2
                                  WHERE byr = ( SELECT  byr 
                                                FROM p_lew_mart_msi_ac.v_cal_calendarday_2
                                                WHERE dat_calendar = CURRENT_DATE - 1
                                              )
                                )
    AND r_cl.dashboard_relevant_fg = 1
  GROUP BY	
      lp_discount.cy_month
    , r_cl.client_id
    , lp_discount.coupon_type_id
)

, lp_cr_dv AS (
  SELECT	
      COALESCE(lp_cr.cy_month, lp_dv.cy_month)              AS cy_month
    , COALESCE(lp_cr.client_id, lp_dv.client_id)            AS client_id
    , COALESCE(lp_cr.coupon_type_id, lp_dv.coupon_type_id)  AS coupon_type_id
    , lp_cr.count_receipt                                   AS count_receipt
    , lp_dv.discount_val                                    AS discount_val
  FROM	lp_cr	                    AS lp_cr
  FULL OUTER JOIN	lp_dv	          AS lp_dv
    ON 	lp_cr.client_id = lp_dv.client_id 
    AND lp_cr.coupon_type_id = lp_dv.coupon_type_id 
    AND lp_cr.cy_month = lp_dv.cy_month
)

, lp_cust AS (
  SELECT	
      lp_cust_act.cy_month                                                          AS cy_month
    , r_cl.client_id                                                                AS client_id
    , lp_cust_act.coupon_type_id                                                    AS coupon_type_id
    , ((1.00001 / 1.00001) * COUNT(DISTINCT lp_cust_act.customer_sid))              AS cnt_cust
  FROM	p_lew_mart_lidl_digital_ac.v_agg_unq_cust_coupon_promo_discount_ldpl_mth_2	  AS lp_cust_act
  
  INNER JOIN	p_lew_mart_msi_ac.v_ref_client_lead_2	                                AS r_cl
    ON 	lp_cust_act.client_id = r_cl.client_id
    
  INNER JOIN	p_lew_mart_msi_ac.v_ref_currency_2	                                  AS curr
    ON 	lp_cust_act.client_id = curr.client_id 
    AND lp_cust_act.curr_tot_id = curr.curr_tot_id
    AND curr.curr_tot_id = 0     
    
  WHERE	lp_cust_act.lidlplus_cust_fg = 'Y'
    AND lp_cust_act.cm_cust_act = 1
    AND lp_cust_act.aspect_id = 2
    AND lp_cust_act.cy_month IN ( SELECT DISTINCT cy_month 
                                  FROM p_lew_mart_msi_ac.v_cal_calendarday_2
                                  WHERE byr = ( SELECT  byr 
                                                FROM p_lew_mart_msi_ac.v_cal_calendarday_2
                                                WHERE dat_calendar = CURRENT_DATE - 1
                                              )
                                )
    AND r_cl.dashboard_relevant_fg = 1
  GROUP BY	
      lp_cust_act.cy_month
    , r_cl.client_id
    , lp_cust_act.coupon_type_id
)

, lp_rcpt AS (
  SELECT	
      cal.cy_month                                                                            AS cy_month
    , r_cl.client_id                                                                          AS client_id
    , (CASE WHEN SUM(lp_rcpt.total_net_val)=0 THEN NULL ELSE SUM(lp_rcpt.total_net_val) END)  AS lp_total_net  --wjxbfs1
    
  FROM	p_lew_mart_lidl_digital_ac.v_agg_client_rcpt_hdr_ldpl_day_2	AS lp_rcpt
  
  INNER JOIN	p_lew_mart_msi_ac.v_cal_calendarday_2	  AS cal
    ON 	lp_rcpt.dwh_cal_dt = cal.dat_calendar
    
  INNER JOIN	p_lew_mart_msi_ac.v_ref_client_lead_2	                AS r_cl
    ON 	lp_rcpt.client_id = r_cl.client_id
    
  INNER JOIN	p_lew_mart_msi_ac.v_ref_currency_2	                  AS curr
    ON 	lp_rcpt.client_id = curr.client_id 
    AND lp_rcpt.curr_tot_id = curr.curr_tot_id
    AND curr.curr_tot_id = 0
      
  WHERE	lp_rcpt.aspect_id = 2
    AND cal.cy_month  IN ( SELECT DISTINCT cy_month 
                                  FROM p_lew_mart_msi_ac.v_cal_calendarday_2
                                  WHERE byr = ( SELECT  byr 
                                                FROM p_lew_mart_msi_ac.v_cal_calendarday_2
                                                WHERE dat_calendar = CURRENT_DATE - 1
                                              )
                          )
    AND r_cl.dashboard_relevant_fg = 1
  GROUP BY	
      cal.cy_month
    , r_cl.client_id
)  

SELECT	
    r_cl.client_id                                                AS client_id
	, r_cl.country_iso_cd                                           AS client_desc
	, m_d.cy_month                                                  AS cy_month
	, m_d.cy_month_name                                             AS cy_month_name
  , m_d.byr                                                       AS YEAR
	, lp_ct.coupon_type_id                                          AS coupon_type_id
	, lp_ct.coupon_type_desc                                        AS coupon_type_desc
	, lp_cts.coupon_type_group_id                                   AS coupon_type_group_id
	, lp_ctg.coupon_type_group_desc                                 AS coupon_type_group_desc
	, lp_ct.coupon_type_subgroup_id                                 AS coupon_type_subgroup_id
	, lp_cts.coupon_type_subgroup_desc                              AS coupon_type_subgroup_desc
	, MAX(lp_cr_dv.count_receipt)                                   AS count_receipt    --Bon ANzahl
	, MAX(lp_cust.cnt_cust)                                         AS cnt_cust         --Kunden Anzahl
	, MAX(lp_cr_dv.discount_val)                                    AS discount_val     --LP Preisveränderung LW
	, CASE  WHEN COALESCE(((DIV0(MAX(lp_cr_dv.discount_val)
            , ( CASE WHEN MAX(lp_rcpt.lp_total_net)=0 THEN NULL 
              ELSE MAX(lp_rcpt.lp_total_net) 
              END))) * 100.0), 0)=0 THEN NULL 
          ELSE COALESCE(((DIV0(MAX(lp_cr_dv.discount_val)
            , ( CASE WHEN MAX(lp_rcpt.lp_total_net)=0 THEN NULL 
              ELSE MAX(lp_rcpt.lp_total_net)
              END))) * 100.0), 0) 
          END                                                              AS discount_pct   --LP Preisveränderung %
FROM	lp_cr_dv	                                                                            AS lp_cr_dv

FULL OUTER JOIN	lp_cust	                                                                    AS lp_cust
  ON 	lp_cr_dv.client_id = lp_cust.client_id 
  AND lp_cr_dv.coupon_type_id = lp_cust.coupon_type_id 
  AND lp_cr_dv.cy_month = lp_cust.cy_month
  
LEFT OUTER JOIN	lp_rcpt	                                                                    AS lp_rcpt
  ON 	COALESCE(lp_cr_dv.client_id, lp_cust.client_id) = lp_rcpt.client_id 
  AND COALESCE(lp_cr_dv.cy_month, lp_cust.cy_month) = lp_rcpt.cy_month
  
INNER JOIN	p_lew_process_mstr_ac.v_ref_ldpl_coupon_type_2	                                  AS lp_ct
  ON 	COALESCE(lp_cr_dv.coupon_type_id, lp_cust.coupon_type_id) = lp_ct.coupon_type_id
  
INNER JOIN	p_lew_process_mstr_ac.v_ref_ldpl_coupon_type_subgroup_2	                          AS lp_cts
  ON 	lp_ct.coupon_type_subgroup_id = lp_cts.coupon_type_subgroup_id
  
INNER JOIN	p_lew_mart_msi_ac.v_ref_client_lead_2	                                            AS r_cl
  ON 	COALESCE(lp_cr_dv.client_id, lp_cust.client_id) = r_cl.client_id
  
INNER JOIN	p_lew_mart_msi_ac.v_cal_month_desc_2	                                AS m_d
  ON 	COALESCE(lp_cr_dv.cy_month, lp_cust.cy_month) = m_d.cy_month

INNER JOIN	p_lew_process_mstr_ac.v_ref_ldpl_coupon_type_group_2	                            AS lp_ctg
  ON 	lp_cts.coupon_type_group_id = lp_ctg.coupon_type_group_id
  
GROUP BY	
    r_cl.client_id
	, r_cl.country_iso_cd
	, m_d.cy_month
  , m_d.byr
	, m_d.cy_month_name
	, lp_ct.coupon_type_id
	, lp_ct.coupon_type_desc
	, lp_cts.coupon_type_group_id
	, lp_ctg.coupon_type_group_desc
	, lp_ct.coupon_type_subgroup_id
	, lp_cts.coupon_type_subgroup_desc
  ;

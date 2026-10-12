/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_BW_LP_MIT_COUPON
#----------------------------------------------------------------------------
# History:
#  1.0  30.08.2023    Ulrich Ross               Init
#                                               User Story 501418
#  1.1  02.10.2023    Ulrich Ross               Add DIV0
#                                               User Story 532827
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_bw_lp_mit_coupon AS WITH LP_CR AS (SELECT LDPL_DAY.cy_month,
   R_CL.client_id,
   LDPL_DAY.coupon_type_id,
   COUNT(DISTINCT LDPL_DAY.receipt_total_net_val_uniq) AS count_receipt
  FROM ldl_p_lew_mart_lidl_digital_ac.v_agg_rcpt_coupon_promo_discount_ldpl_day AS LDPL_DAY
   INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_client_lead AS R_CL ON LDPL_DAY.client_id = R_CL.client_id
   INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_currency AS CURR ON LDPL_DAY.client_id = CURR.client_id AND LDPL_DAY.curr_tot_id
       = CURR.curr_tot_id AND CURR.curr_tot_id = 0
  WHERE LDPL_DAY.lidlplus_cust_fg = 'Y'
   AND LDPL_DAY.aspect_id = 2
   AND R_CL.dashboard_relevant_fg = 1
   AND LDPL_DAY.cy_month IN (SELECT DISTINCT cy_month
     FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday
     WHERE byr = (SELECT byr
        FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday
        WHERE dat_calendar = DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)))
  GROUP BY LDPL_DAY.cy_month,
   R_CL.client_id,
   LDPL_DAY.coupon_type_id), LP_DV AS (SELECT LP_DISCOUNT.cy_month,
   R_CL0.client_id,
   LP_DISCOUNT.coupon_type_id,
    CASE
    WHEN SUM(LP_DISCOUNT.cm_discount_val) = 0
    THEN NULL
    ELSE SUM(LP_DISCOUNT.cm_discount_val)
    END AS discount_val
  FROM ldl_p_lew_mart_lidl_digital_ac.v_agg_unq_cust_coupon_promo_discount_ldpl_mth AS LP_DISCOUNT
   INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_client_lead AS R_CL0 ON LP_DISCOUNT.client_id = R_CL0.client_id
   INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_currency AS CURR0 ON LP_DISCOUNT.client_id = CURR0.client_id AND LP_DISCOUNT.curr_tot_id
       = CURR0.curr_tot_id AND CURR0.curr_tot_id = 0
  WHERE LP_DISCOUNT.lidlplus_cust_fg = 'Y'
   AND LP_DISCOUNT.aspect_id = 2
   AND LP_DISCOUNT.cy_month IN (SELECT DISTINCT cy_month
     FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday
     WHERE byr = (SELECT byr
        FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday
        WHERE dat_calendar = DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)))
   AND R_CL0.dashboard_relevant_fg = 1
  GROUP BY LP_DISCOUNT.cy_month,
   R_CL0.client_id,
   LP_DISCOUNT.coupon_type_id), LP_CR_DV AS (SELECT COALESCE(lp_cr.cy_month, lp_dv.cy_month) AS cy_month,
   COALESCE(lp_cr.client_id, lp_dv.client_id) AS client_id,
   COALESCE(lp_cr.coupon_type_id, lp_dv.coupon_type_id) AS coupon_type_id,
   lp_cr.count_receipt,
   lp_dv.discount_val
  FROM LP_CR AS lp_cr
   FULL JOIN LP_DV AS lp_dv ON lp_cr.client_id = lp_dv.client_id AND lp_cr.coupon_type_id = lp_dv.coupon_type_id AND
     lp_cr.cy_month = lp_dv.cy_month), LP_CUST AS (SELECT LP_CUST_ACT.cy_month,
   R_CL1.client_id,
   LP_CUST_ACT.coupon_type_id,
     1.00001 / 1.00001 * COUNT(DISTINCT LP_CUST_ACT.customer_sid) AS cnt_cust
  FROM ldl_p_lew_mart_lidl_digital_ac.v_agg_unq_cust_coupon_promo_discount_ldpl_mth AS LP_CUST_ACT
   INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_client_lead AS R_CL1 ON LP_CUST_ACT.client_id = R_CL1.client_id
   INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_currency AS CURR1 ON LP_CUST_ACT.client_id = CURR1.client_id AND LP_CUST_ACT.curr_tot_id
       = CURR1.curr_tot_id AND CURR1.curr_tot_id = 0
  WHERE LP_CUST_ACT.lidlplus_cust_fg = 'Y'
   AND LP_CUST_ACT.cm_cust_act = 1
   AND LP_CUST_ACT.aspect_id = 2
   AND LP_CUST_ACT.cy_month IN (SELECT DISTINCT cy_month
     FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday
     WHERE byr = (SELECT byr
        FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday
        WHERE dat_calendar = DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)))
   AND R_CL1.dashboard_relevant_fg = 1
  GROUP BY LP_CUST_ACT.cy_month,
   R_CL1.client_id,
   LP_CUST_ACT.coupon_type_id), LP_RCPT AS (SELECT CAL.cy_month,
   R_CL2.client_id,
    CASE
    WHEN SUM(LP_RCPT.total_net_val) = 0
    THEN NULL
    ELSE SUM(LP_RCPT.total_net_val)
    END AS lp_total_net
  FROM ldl_p_lew_mart_lidl_digital_ac.v_agg_client_rcpt_hdr_ldpl_day AS LP_RCPT
   INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_calendarday AS CAL ON LP_RCPT.dwh_cal_dt = CAL.dat_calendar
   INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_client_lead AS R_CL2 ON LP_RCPT.client_id = R_CL2.client_id
   INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_currency AS CURR2 ON LP_RCPT.client_id = CURR2.client_id AND LP_RCPT.curr_tot_id
       = CURR2.curr_tot_id AND CURR2.curr_tot_id = 0
  WHERE LP_RCPT.aspect_id = 2
   AND CAL.cy_month IN (SELECT DISTINCT cy_month
     FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday
     WHERE byr = (SELECT byr
        FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday
        WHERE dat_calendar = DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)))
   AND R_CL2.dashboard_relevant_fg = 1
  GROUP BY CAL.cy_month,
   R_CL2.client_id) (-- wjxbfs1
 -- Bon ANzahl
 -- Kunden Anzahl
 -- LP Preisveränderung LW
 -- LP Preisveränderung %

  SELECT R_CL3.client_id,
   R_CL3.country_iso_cd AS client_desc,
   M_D.cy_month,
   M_D.cy_month_name,
   M_D.byr AS year,
   LP_CT.coupon_type_id,
   LP_CT.coupon_type_desc,
   LP_CTS.coupon_type_group_id,
   LP_CTG.coupon_type_group_desc,
   LP_CT.coupon_type_subgroup_id,
   LP_CTS.coupon_type_subgroup_desc,
   MAX(lp_cr_dv.count_receipt) AS count_receipt,
   MAX(lp_cust.cnt_cust) AS cnt_cust,
   MAX(lp_cr_dv.discount_val) AS discount_val,
    CASE
    WHEN COALESCE(IF(CASE
          WHEN MAX(lp_rcpt.lp_total_net) = 0
          THEN NULL
          ELSE MAX(lp_rcpt.lp_total_net)
          END = 0, 0, SAFE_DIVIDE(MAX(lp_cr_dv.discount_val), CASE
          WHEN MAX(lp_rcpt.lp_total_net) = 0
          THEN NULL
          ELSE MAX(lp_rcpt.lp_total_net)
          END)) * 100.0, 0) = 0
    THEN NULL
    ELSE COALESCE(IF(CASE
         WHEN MAX(lp_rcpt.lp_total_net) = 0
         THEN NULL
         ELSE MAX(lp_rcpt.lp_total_net)
         END = 0, 0, SAFE_DIVIDE(MAX(lp_cr_dv.discount_val), CASE
         WHEN MAX(lp_rcpt.lp_total_net) = 0
         THEN NULL
         ELSE MAX(lp_rcpt.lp_total_net)
         END)) * 100.0, 0)
    END AS discount_pct
  FROM LP_CR_DV AS lp_cr_dv
   FULL JOIN LP_CUST AS lp_cust ON lp_cr_dv.client_id = lp_cust.client_id AND lp_cr_dv.coupon_type_id = lp_cust.coupon_type_id
       AND lp_cr_dv.cy_month = lp_cust.cy_month
   LEFT JOIN LP_RCPT AS lp_rcpt ON COALESCE(lp_cr_dv.client_id, lp_cust.client_id) = lp_rcpt.client_id AND COALESCE(lp_cr_dv
      .cy_month, lp_cust.cy_month) = lp_rcpt.cy_month
   INNER JOIN ldl_p_lew_process_mstr_ac.v_ref_ldpl_coupon_type AS LP_CT ON COALESCE(lp_cr_dv.coupon_type_id, lp_cust.coupon_type_id
     ) = LP_CT.coupon_type_id
   INNER JOIN ldl_p_lew_process_mstr_ac.v_ref_ldpl_coupon_type_subgroup AS LP_CTS ON LP_CT.coupon_type_subgroup_id =
    LP_CTS.coupon_type_subgroup_id
   INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_client_lead AS R_CL3 ON COALESCE(lp_cr_dv.client_id, lp_cust.client_id) =
    R_CL3.client_id
   INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_month_desc AS M_D ON COALESCE(lp_cr_dv.cy_month, lp_cust.cy_month) = M_D.cy_month
    
   INNER JOIN ldl_p_lew_process_mstr_ac.v_ref_ldpl_coupon_type_group AS LP_CTG ON LP_CTS.coupon_type_group_id = LP_CTG.coupon_type_group_id
    
  GROUP BY R_CL3.client_id,
   client_desc,
   M_D.cy_month,
   year,
   M_D.cy_month_name,
   LP_CT.coupon_type_id,
   LP_CT.coupon_type_desc,
   LP_CTS.coupon_type_group_id,
   LP_CTG.coupon_type_group_desc,
   LP_CT.coupon_type_subgroup_id,
   LP_CTS.coupon_type_subgroup_desc);
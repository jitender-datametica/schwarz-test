/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: 20181022_1867_Agg_NF_Reichweite_Rep3
#            DDL for t_agg_mth_nf_coverage
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2018-10-24 Rodrigo Cione           Initial version 
#                                         Patch: 20181022_1867_Agg_NF_Reichweite_Rep3
#                                         Create view LDL.P_LEW_MART_LEAD.v_agg_mth_nf_coverage_1
#  1.1 2020-12-30 Michal Malinowski       20201214_2691_Frischfish_adjustments, REP3-7935
#                                         FrischFish WGI ID Conversion (3=>30,32) && (i(1,2,4,5,6,7,8,9)=>(i*10...)
#
#----------------------------------------------------------------------------
*/

/*
#----------------------------------------------------------------------------
#  View DDL
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_agg_mth_nf_coverage_1 (client_id, country_group_id, cy_week_partial_week_id,
month_id, byr, currency_iso_cd, stock_mth_asis, stock_mth_py, revenue_mth_asis, revenue_mth_py, revenue_sum_cy_asis,
revenue_sum_py, revenue_sum_plan_cy, revenue_sum_plan_yr_py, revenue_plan_mth_asis, revenue_plan_mth_py,
revenue_plan_next_mth, revenue_plan_next_mth_py, coverage_cy, coverage_py, coverage_delta)
OPTIONS(DESCRIPTION = `$Revision: 16563 $ `) AS /* check with team which one is correct v_stock_wh_pwk_agg_base_nf_1 */
/* As for calculation we always need sum of last 12 month So for last month PY we need to go 12 months back */
/* get all the bestand data at client and currency level for latest last day of month and previous year same month last day */
/* Sum of revenue asis for last 12 month from current month */
/* Sum of revenue planed for last 12 month from current month */ /* Filter for NON Food data */
/* As for calculation we always need sum of last 12 month So for last month PY we need to go 12 months back */
/* Fetch Planed revenue for current Month */
/* gets the revenue value for current month, last 12 months, planned value and more */ SELECT bes.client_id,
 bes.ctry_grp_id AS country_group_id,
 bes.cy_week_partial_week_id,
 bes.month_id,
 bes.byr,
 bes.curr_cd AS currency_iso_cd,
 bes.stk_ld_mth AS stock_mth_asis,
 bes.stk_py_ld_mth AS stock_mth_py,
 um.revn_mth AS revenue_mth_asis,
 um.revn_mth_py AS revenue_mth_py,
 um.revn_yr_sum AS revenue_sum_cy_asis,
 um.revn_yr_sum_py AS revenue_sum_py,
 um.revn_yr_sum_pln AS revenue_sum_plan_cy,
 um.revn_yr_sum_pln_py AS revenue_sum_plan_yr_py,
 um.revn_mth_pln AS revenue_plan_mth_asis,
 um.revn_mth_pln_py AS revenue_plan_mth_py,
 um.revn_next_mth_pln AS revenue_plan_next_mth,
 um.revn_next_mth_pln_py AS revenue_plan_next_mth_py,
  CASE
  WHEN um.revn_next_mth_pln = 0 OR um.revn_yr_sum_pln = 0
  THEN 0
  ELSE bes.stk_ld_mth / (um.revn_next_mth_pln * (um.revn_yr_sum / um.revn_yr_sum_pln)) * 4.33
  END AS coverage_cy,
  CASE
  WHEN um.revn_next_mth_pln_py = 0 OR um.revn_yr_sum_pln_py = 0
  THEN 0
  ELSE bes.stk_py_ld_mth / (um.revn_next_mth_pln_py * (um.revn_yr_sum_py / um.revn_yr_sum_pln_py)) * 4.33
  END AS coverage_py,
   CASE
   WHEN um.revn_next_mth_pln = 0 OR um.revn_yr_sum_pln = 0
   THEN 0
   ELSE bes.stk_ld_mth / (um.revn_next_mth_pln * (um.revn_yr_sum / um.revn_yr_sum_pln)) * 4.33
   END - CASE
   WHEN um.revn_next_mth_pln_py = 0 OR um.revn_yr_sum_pln_py = 0
   THEN 0
   ELSE bes.stk_py_ld_mth / (um.revn_next_mth_pln_py * (um.revn_yr_sum_py / um.revn_yr_sum_pln_py)) * 4.33
   END AS coverage_delta
FROM (SELECT STK.client_id,
   GI.country_group_id AS ctry_grp_id,
   STK.cy_month_id AS month_id,
   STK.cy_week_partial_week_id,
   STK.byr,
   STK.curr_cd,
   SUM(STK.stock_wh_asis) AS stk_ld_mth,
   SUM(STK.stock_wh_scdp1y) AS stk_py_ld_mth
  FROM ldl_p_lew_mart_lead_ac.v_stock_wh_pwk_agg_base_nf_1 AS STK
   INNER JOIN (SELECT CAL.cy_month,
     CAL_WK.cy_week_partial_week_id,
     CAL.cy_month_seq
    FROM ldl_p_lew_core_ac.v_cal_calendarday_1 AS CAL
     INNER JOIN ldl_p_lew_core_ac.v_wawi_cal_week_partial_week_rel_1 AS CAL_WK ON CAL.cal_dt = CAL_WK.dat_calendar
    WHERE CAL.last_day_month_fg = 1
     AND CAL.cy_month_seq BETWEEN - 35 AND CASE
       WHEN LAST_DAY(CURRENT_DATE, MONTH) = CURRENT_DATE
       THEN 0
       ELSE - 1
       END
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(CAL.cy_month AS STRING) ORDER BY CAL_WK.cy_week_partial_week_id
          IS NULL, CAL_WK.cy_week_partial_week_id)) = 1) AS cal ON STK.cy_month_id = cal.cy_month
   INNER JOIN ldl_p_lew_core_ac.v_wawi_org_client_skey_1 AS GI ON STK.client_id = GI.client_id
  WHERE STK.last_day_month_fg = 1
   AND cal.cy_month_seq BETWEEN - 12 AND 0
  GROUP BY STK.client_id,
   ctry_grp_id,
   month_id,
   STK.cy_week_partial_week_id,
   STK.byr,
   STK.curr_cd) AS bes
 LEFT JOIN (SELECT agg.client_id,
   agg.cy_month AS month_id,
   agg.currency_iso_cd,
   agg.revenue_mth_asis AS revn_mth,
   SUM(agg.revenue_mth_asis) OVER (PARTITION BY CAST(agg.client_id AS STRING), agg.currency_iso_cd ORDER BY agg.cy_month
      IS NULL DESC, agg.cy_month DESC ROWS BETWEEN 0 FOLLOWING AND 11 FOLLOWING) AS revn_yr_sum,
   PLAN.val_indicator AS revn_mth_pln,
   SUM(PLAN.val_indicator) OVER (PARTITION BY CAST(agg.client_id AS STRING), agg.currency_iso_cd ORDER BY agg.cy_month
      IS NULL DESC, agg.cy_month DESC ROWS BETWEEN 0 FOLLOWING AND 11 FOLLOWING) AS revn_yr_sum_pln,
   PLAN2.val_indicator AS revn_next_mth_pln,
   MAX(agg.revenue_mth_asis) OVER (PARTITION BY CAST(agg.client_id AS STRING), agg.currency_iso_cd ORDER BY agg.cy_month
      IS NULL DESC, agg.cy_month DESC ROWS BETWEEN 12 FOLLOWING AND 12 FOLLOWING) AS revn_mth_py,
   SUM(agg.revenue_mth_asis) OVER (PARTITION BY CAST(agg.client_id AS STRING), agg.currency_iso_cd ORDER BY agg.cy_month
      IS NULL DESC, agg.cy_month DESC ROWS BETWEEN 12 FOLLOWING AND 23 FOLLOWING) AS revn_yr_sum_py,
   MAX(PLAN.val_indicator) OVER (PARTITION BY CAST(agg.client_id AS STRING), agg.currency_iso_cd ORDER BY agg.cy_month
      IS NULL DESC, agg.cy_month DESC ROWS BETWEEN 12 FOLLOWING AND 12 FOLLOWING) AS revn_mth_pln_py,
   SUM(PLAN.val_indicator) OVER (PARTITION BY CAST(agg.client_id AS STRING), agg.currency_iso_cd ORDER BY agg.cy_month
      IS NULL DESC, agg.cy_month DESC ROWS BETWEEN 12 FOLLOWING AND 23 FOLLOWING) AS revn_yr_sum_pln_py,
   MAX(PLAN2.val_indicator) OVER (PARTITION BY CAST(agg.client_id AS STRING), agg.currency_iso_cd ORDER BY agg.cy_month
      IS NULL DESC, agg.cy_month DESC ROWS BETWEEN 12 FOLLOWING AND 12 FOLLOWING) AS revn_next_mth_pln_py
  FROM (SELECT EJR.client_id,
     EJR.cy_month,
     cal.cy_month_next_1m,
     CRY.currency_iso_cd,
     SUM(EJR.sales_net_val / CRY.rate_currency_exchange) AS val_rtl_net_ejr,
     SUM(EJR.return_net_val / CRY.rate_currency_exchange) AS val_return_net_ejr,
      IFNULL(SUM(EJR.sales_net_val / CRY.rate_currency_exchange), 0) + IFNULL(SUM(EJR.return_net_val / CRY.rate_currency_exchange
         ), 0) AS revenue_mth_asis
    FROM ldl_p_lew_bil_ac.v_agg_pos_wh_mth_item_asis_1 AS EJR
     INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_1 AS CRY ON EJR.client_id = CRY.client_id AND
       CURRENT_DATE BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end
     INNER JOIN ldl_p_lew_bil_ac.v_item_hierarchy_1 AS ITH ON EJR.item_sid = ITH.item_sid AND EJR.client_id = ITH.client_id
         AND CAST(ITH.src_itemgrp_int_cd AS INTEGER) IN (7, 70)
     INNER JOIN (SELECT CAL0.cy_month,
       FORMAT_DATE('%Y%m', DATE(IF(CAL0.cal_dt = LAST_DAY(CAL0.cal_dt), LAST_DAY(DATE_ADD(CAL0.cal_dt, INTERVAL 1 MONTH)
           ), DATE_ADD(CAL0.cal_dt, INTERVAL 1 MONTH)))) AS cy_month_next_1m,
       CAL_WK0.cy_week_partial_week_id
      FROM ldl_p_lew_core_ac.v_cal_calendarday_1 AS CAL0
       INNER JOIN ldl_p_lew_core_ac.v_wawi_cal_week_partial_week_rel_1 AS CAL_WK0 ON CAL0.cal_dt = CAL_WK0.dat_calendar
      WHERE CAL0.last_day_month_fg = 1
       AND CAL0.cy_month_seq BETWEEN - 35 AND CASE
         WHEN LAST_DAY(CURRENT_DATE, MONTH) = CURRENT_DATE
         THEN 0
         ELSE - 1
         END
      QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(CAL0.cy_month AS STRING) ORDER BY CAL_WK0.cy_week_partial_week_id
            IS NULL, CAL_WK0.cy_week_partial_week_id)) = 1) AS cal ON EJR.cy_month = cal.cy_month
    GROUP BY EJR.client_id,
     EJR.cy_month,
     cal.cy_month_next_1m,
     CRY.currency_iso_cd) AS agg
   LEFT JOIN ldl_p_lew_mart_lead_ac.v_kpges_plan_mth_country_1 AS PLAN ON agg.client_id = PLAN.client_id AND agg.currency_iso_cd
        = PLAN.currency_iso_cd AND agg.cy_month = PLAN.cy_month AND PLAN.indicator_id = 293
     /* Fetch Planed revenue for next Month */
   LEFT JOIN ldl_p_lew_mart_lead_ac.v_kpges_plan_mth_country_1 AS PLAN2 ON agg.client_id = PLAN2.client_id AND agg.currency_iso_cd
        = PLAN2.currency_iso_cd AND PLAN2.cy_month = CAST(agg.cy_month_next_1m AS FLOAT64) AND PLAN2.indicator_id = 293
  ) AS um ON bes.client_id = um.client_id AND bes.curr_cd = um.currency_iso_cd AND bes.month_id = um.month_id;
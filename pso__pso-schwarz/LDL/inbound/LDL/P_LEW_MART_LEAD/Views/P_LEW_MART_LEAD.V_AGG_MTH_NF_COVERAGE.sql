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
#                                         Create view P_LEW_MART_LEAD.v_agg_mth_nf_coverage
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

CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_AGG_MTH_NF_COVERAGE
COMMENT = '$Revision: 16563 $ '

(
   client_id
 , country_group_id
 , cy_week_partial_week_id
 , month_id
 , byr
 , currency_iso_cd
 , stock_mth_asis
 , stock_mth_py
 , revenue_mth_asis
 , revenue_mth_py
 , revenue_sum_cy_asis
 , revenue_sum_py
 , revenue_sum_plan_cy
 , revenue_sum_plan_yr_py
 , revenue_plan_mth_asis
 , revenue_plan_mth_py
 , revenue_plan_next_mth
 , revenue_plan_next_mth_py
 , coverage_cy
 , coverage_py
 , coverage_delta
) AS
SELECT
  bes.client_id               AS client_id
, bes.ctry_grp_id             AS country_group_id
, bes.cy_week_partial_week_id AS cy_week_partial_week_id
, bes.month_id                AS month_id
, bes.byr                     AS byr
, bes.curr_cd                 AS currency_iso_cd
, bes.stk_ld_mth              AS stock_mth_asis
, bes.stk_py_ld_mth           AS stock_mth_py
, um.revn_mth                 AS revenue_mth_asis
, um.revn_mth_py              AS revenue_mth_py
, um.revn_yr_sum              AS revenue_sum_cy_asis
, um.revn_yr_sum_py           AS revenue_sum_py
, um.revn_yr_sum_pln          AS revenue_sum_plan_cy
, um.revn_yr_sum_pln_py       AS revenue_sum_plan_yr_py
, um.revn_mth_pln             AS revenue_plan_mth_asis
, um.revn_mth_pln_py          AS revenue_plan_mth_py
, um.revn_next_mth_pln        AS revenue_plan_next_mth
, um.revn_next_mth_pln_py     AS revenue_plan_next_mth_py
, CASE WHEN um.revn_next_mth_pln = 0 OR um.revn_yr_sum_pln = 0
       THEN 0
       ELSE (bes.stk_ld_mth/(um.revn_next_mth_pln*(um.revn_yr_sum/um.revn_yr_sum_pln)))*4.33 
  END                         AS coverage_cy
, CASE WHEN um.revn_next_mth_pln_py = 0 OR um.revn_yr_sum_pln_py = 0
       THEN 0
       ELSE (bes.stk_py_ld_mth/(um.revn_next_mth_pln_py*(um.revn_yr_sum_py/um.revn_yr_sum_pln_py)))*4.33
  END                         AS coverage_py
, coverage_cy - coverage_py   AS coverage_delta

FROM 
(
   SELECT 
     stk.client_id               AS client_id
   , gi.country_group_id         AS ctry_grp_id
   , stk.cy_month_id             AS month_id
   , stk.cy_week_partial_week_id AS cy_week_partial_week_id
   , stk.byr                     AS byr
   , stk.curr_cd                 AS curr_cd
   , SUM(stk.stock_wh_asis)      AS stk_ld_mth
   , SUM(stk.stock_wh_scdp1y)    AS stk_py_ld_mth

   FROM  P_LEW_MART_LEAD_AC.v_stock_wh_pwk_agg_base_nf AS stk /* check with team which one is correct v_stock_wh_pwk_agg_base_nf*/

   INNER JOIN  (
                SELECT
                  cal.cy_month                                                           AS cy_month
                , cal_wk.cy_week_partial_week_id                                         AS cy_week_partial_week_id
                , cal.cy_month_seq                                                       AS cy_month_seq
                
                FROM  P_LEW_CORE_AC.v_cal_calendarday  cal
                
                INNER JOIN P_LEW_CORE_AC.v_wawi_cal_week_partial_week_rel  cal_wk
                ON cal_wk.dat_calendar=cal.cal_dt
                
                WHERE cal.last_day_month_fg = 1
                AND cal.cy_month_seq BETWEEN -35 AND CASE WHEN LAST_DAY(CURRENT_DATE)=CURRENT_DATE
                                                          THEN 0
                                                          ELSE -1
                                                     END /* As for calculation we always need sum of last 12 month So for last month PY we need to go 12 months back */
                QUALIFY ROW_NUMBER () Over (PARTITION  BY cal.cy_month  ORDER BY cy_week_partial_week_id ASC )=1
               )  AS cal
   ON stk.cy_month_id = cal.cy_month    

   INNER JOIN P_LEW_CORE_AC.v_wawi_org_client_skey AS gi
   ON stk.client_id = gi.client_id

   WHERE stk.last_day_month_fg = 1
     AND cal.cy_month_seq BETWEEN -12 AND 0

   GROUP BY 
     stk.client_id
   , gi.country_group_id 
   , stk.cy_month_id
   , stk.cy_week_partial_week_id
   , stk.byr
   , stk.curr_cd
) AS bes /* get all the bestand data at client and currency level for latest last day of month and previous year same month last day*/

LEFT OUTER JOIN 
(
   SELECT
    agg.client_id                                                                                                                                       AS client_id
   , agg.cy_month                                                                                                                                        AS month_id
   , agg.currency_iso_cd                                                                                                                                 AS currency_iso_cd
   , agg.revenue_mth_asis                                                                                                                                AS revn_mth
   /* Sum of revenue asis for last 12 month from current month */
   , SUM(revn_mth)          Over(PARTITION BY agg.client_id,agg.currency_iso_cd ORDER BY agg.cy_month DESC ROWS  BETWEEN 0 FOLLOWING AND 11 FOLLOWING )  AS revn_yr_sum
   , plan.val_indicator                                                                                                                                  AS revn_mth_pln
   /* Sum of revenue planed for last 12 month from current month */
   , SUM(revn_mth_pln)      Over(PARTITION BY agg.client_id,agg.currency_iso_cd ORDER BY agg.cy_month DESC ROWS  BETWEEN 0 FOLLOWING AND 11 FOLLOWING )  AS revn_yr_sum_pln
   , plan2.val_indicator                                                                                                                                 AS revn_next_mth_pln
   , MAX(revn_mth)          Over(PARTITION BY agg.client_id,agg.currency_iso_cd ORDER BY agg.cy_month DESC ROWS  BETWEEN 12 FOLLOWING AND 12 FOLLOWING ) AS revn_mth_py
   , SUM(revn_mth)          Over(PARTITION BY agg.client_id,agg.currency_iso_cd ORDER BY agg.cy_month DESC ROWS  BETWEEN 12 FOLLOWING AND 23 FOLLOWING ) AS revn_yr_sum_py
   , MAX(revn_mth_pln)      Over(PARTITION BY agg.client_id,agg.currency_iso_cd ORDER BY agg.cy_month DESC ROWS  BETWEEN 12 FOLLOWING AND 12 FOLLOWING ) AS revn_mth_pln_py
   , SUM(revn_mth_pln)      Over(PARTITION BY agg.client_id,agg.currency_iso_cd ORDER BY agg.cy_month DESC ROWS  BETWEEN 12 FOLLOWING AND 23 FOLLOWING ) AS revn_yr_sum_pln_py
   , MAX(revn_next_mth_pln) Over(PARTITION BY agg.client_id,agg.currency_iso_cd ORDER BY agg.cy_month DESC ROWS  BETWEEN 12 FOLLOWING AND 12 FOLLOWING ) AS revn_next_mth_pln_py

   FROM
   (   
      SELECT 
        ejr.client_id                                                AS client_id
      , ejr.cy_month                                                 AS cy_month
      , cal.cy_month_next_1m                                         AS cy_month_next_1m
      , cry.currency_iso_cd                                          AS currency_iso_cd
      , SUM(ejr.sales_net_val  / cry.rate_currency_exchange)         AS val_rtl_net_ejr 
      , SUM(ejr.return_net_val / cry.rate_currency_exchange)         AS val_return_net_ejr
      , ZEROIFNULL(val_rtl_net_ejr) + ZEROIFNULL(val_return_net_ejr) AS revenue_mth_asis

      FROM P_LEW_BIL_AC.v_agg_pos_wh_mth_item_asis AS ejr    

      INNER JOIN P_LEW_CORE_AC.v_wawi_ref_client_currency_rate AS cry 
      ON  ejr.client_id = cry.client_id 
      AND CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end  

      INNER JOIN P_LEW_BIL_AC.v_item_hierarchy AS ith
      ON  ejr.item_sid           = ith.item_sid
      AND ejr.client_id          = ith.client_id
      AND ith.src_itemgrp_int_cd IN ( 7 , 70 )     /* Filter for NON Food data */

      INNER JOIN  (
               SELECT
                 cal.cy_month                                             AS cy_month
               , TO_VARCHAR(ADD_MONTHS(cal.cal_dt,1)::DATE,'YYYYMM')      AS cy_month_next_1m
               , cal_wk.cy_week_partial_week_id                           AS cy_week_partial_week_id
               
               FROM  P_LEW_CORE_AC.v_cal_calendarday  cal

               INNER JOIN P_LEW_CORE_AC.v_wawi_cal_week_partial_week_rel  cal_wk
               ON cal_wk.dat_calendar=cal.cal_dt

               WHERE cal.last_day_month_fg = 1
               AND cal.cy_month_seq BETWEEN -35 AND CASE WHEN LAST_DAY(CURRENT_DATE)=CURRENT_DATE
                                                         THEN 0
                                                         ELSE -1
                                                    END /* As for calculation we always need sum of last 12 month So for last month PY we need to go 12 months back */
               QUALIFY ROW_NUMBER () Over (PARTITION  BY cal.cy_month  ORDER BY cy_week_partial_week_id ASC )=1
               )  AS cal
      ON ejr.cy_month = cal.cy_month    
      GROUP BY 
        ejr.client_id
      , ejr.cy_month
      , cal.cy_month_next_1m
      , cry.currency_iso_cd  
   ) AS agg    

   /* Fetch Planed revenue for current Month */
   LEFT OUTER JOIN P_LEW_MART_LEAD_AC.v_kpges_plan_mth_country AS plan   
   ON   plan.client_id       = agg.client_id
   AND  plan.currency_iso_cd = agg.currency_iso_cd
   AND  plan.cy_month        = agg.cy_month
   AND  plan. indicator_id   = 293

   /* Fetch Planed revenue for next Month */
   LEFT OUTER JOIN P_LEW_MART_LEAD_AC.v_kpges_plan_mth_country AS plan2   
   ON   plan2.client_id       = agg.client_id
   AND  plan2.currency_iso_cd = agg.currency_iso_cd
   AND  plan2.cy_month        = agg.cy_month_next_1m
   AND  plan2. indicator_id   = 293
) AS um /* gets the revenue value for current month, last 12 months, planned value and more*/
ON  bes.client_id = um.client_id
AND bes.curr_cd   = um.currency_iso_cd
AND bes.month_id  = um.month_id
;


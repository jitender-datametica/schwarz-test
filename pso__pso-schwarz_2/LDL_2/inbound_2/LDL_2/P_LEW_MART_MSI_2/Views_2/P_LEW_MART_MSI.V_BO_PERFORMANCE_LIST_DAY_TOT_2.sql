CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_BO_PERFORMANCE_LIST_DAY_TOT_2	
 /**************************************************************************
 * Created by Jens Thole	
 * on 14.06.2018	
 * Inhalt: finale Zielstruktur der Tagesebenen-Schnittstelle-Wochenaggregat (total) der BO_PERORMANCE_LIST	
 * Quellen: MART_MSI:t_bo_base_performance_list_2 (alleinige Basisstruktur)	
 * direkte Quelle:   MART_MSI:v_bo_performance_list_day_2	
 * Relevante Measure-Values werden ermittelt. Es findet kein Ranking statt.	
 *	
 * Granularität (Gewinnerstore, Woche_2) - keine weitere Verdichtung	
 **************************************************************************/	
AS	
SELECT	
  client_id	
, store_id	
, orig_store_nr	
, store_desc	
, city	
, wh_id	
, wh_desc	
, sales_manager_id	
, sales_manager_name	
, account_manager_id	
, account_manager_name	
, cy_week	
, currency_iso_cd	
, plan_val_turnover	
, plan_val_turnover_net	
, plan_val_hours	
, plan_val_inv_training	
, val_retail_asis	
, val_retail_net_asis	
, cnt_customer_asis	
, time_working_netto_std	
, Coalesce(miss_times_perf,0)                                                                                                     AS miss_times_perf	
, (Cast(val_retail_asis AS DECIMAL(18,4)) - plan_turnover_calc_ums_diff) / NullIfZero (plan_turnover_calc_ums_diff) * 100         AS diff_val_retail_pct	
, (val_retail_net_asis - plan_turnover_calc_ums_dif_net) / NullIfZero (plan_turnover_calc_ums_dif_net) * 100                      AS diff_val_retail_net_pct	
, time_working_netto_std + Coalesce(miss_times_perf,0) - plan_hours_calc_hrs_diff                                                 AS diff_hours	
, plan_val_turnover / NullIfZero (plan_val_hours)                                                                                 AS plan_productivity	
, Cast(plan_val_turnover_net AS DECIMAL(19,5)) / NullIfZero (plan_val_hours)                                                      AS plan_productivity_net	
, plan_turnover_calc_prod_diff / NullIfZero (plan_hours_calc_prod_diff)                                                           AS plan_productivity_calc	
, Cast(plan_turnover_calc_pro_dif_net AS DECIMAL(19,5)) / NullIfZero (plan_hours_calc_prod_diff)                                  AS plan_productivity_net_calc	
, Cast(val_retail_calc_prod_diff AS DECIMAL(18,4)) / NullIfZero (hrs_calc_prod_diff + Coalesce(miss_times_perf_calc_prod_diff,0)) AS act_productivity	
, val_retail_calc_prod_diff_net/ NullIfZero (hrs_calc_prod_diff + Coalesce(miss_times_perf_calc_prod_diff,0))                     AS act_productivity_net	
, act_productivity - plan_productivity_calc                                                                                       AS diff_plan_act_productivity	
, act_productivity_net - plan_productivity_net_calc                                                                               AS diff_plan_act_productivity_net	
FROM	
(	
    SELECT	
      client_id	
    , store_id	
    , Max(orig_store_nr)                 AS orig_store_nr	
    , Max(store_desc)                    AS store_desc	
    , Max(city)                          AS city	
    , Max(wh_id)                         AS wh_id	
    , Max(wh_desc)                       AS wh_desc	
    , Max(sales_manager_id)              AS sales_manager_id	
    , Max(sales_manager_name)            AS sales_manager_name	
    , Max(account_manager_id)            AS account_manager_id	
    , Max(account_manager_name)          AS account_manager_name	
    , cy_week	
    , Max(currency_iso_cd)               AS currency_iso_cd	
    , Sum(plan_val_turnover)             AS plan_val_turnover	
    , Sum(plan_val_turnover_net)         AS plan_val_turnover_net	
    , Sum(plan_val_hours)                AS plan_val_hours	
    , Sum(plan_val_inv_training)         AS plan_val_inv_training	
    , Sum(val_retail_asis)               AS val_retail_asis	
    , Sum(val_retail_net_asis)           AS val_retail_net_asis	
    , Sum(cnt_customer_asis)             AS cnt_customer_asis	
    , Sum(time_working_netto_std)        AS time_working_netto_std	
    , Sum(miss_times_perf)               AS miss_times_perf	
    , Sum(plan_turnover_calc_ums_diff)   AS plan_turnover_calc_ums_diff	
    , Sum(plan_turnover_calc_ums_dif_net)AS plan_turnover_calc_ums_dif_net	
    , Sum(plan_turnover_calc_prod_diff)  AS plan_turnover_calc_prod_diff	
    , Sum(plan_turnover_calc_pro_dif_net)AS plan_turnover_calc_pro_dif_net	
    , Sum(plan_hours_calc_hrs_diff)      AS plan_hours_calc_hrs_diff	
    , Sum(plan_hours_calc_prod_diff)     AS plan_hours_calc_prod_diff	
    , Sum(val_retail_calc_prod_diff)     AS val_retail_calc_prod_diff	
    , Sum(val_retail_calc_prod_diff_net) AS val_retail_calc_prod_diff_net	
    , Sum(hrs_calc_prod_diff)            AS hrs_calc_prod_diff	
    , Sum(miss_times_perf_calc_prod_diff)AS miss_times_perf_calc_prod_diff	
    FROM p_lew_mart_msi.v_bo_performance_list_day_2	
    group by client_id	
           , store_id	
           , cy_week	
) as agg	
;
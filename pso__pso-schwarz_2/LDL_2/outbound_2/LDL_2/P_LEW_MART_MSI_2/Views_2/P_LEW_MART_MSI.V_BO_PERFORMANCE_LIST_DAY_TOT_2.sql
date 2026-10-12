/* * Created by Jens Thole	
 * on 14.06.2018	
 * Inhalt: finale Zielstruktur der Tagesebenen-Schnittstelle-Wochenaggregat (total) der BO_PERORMANCE_LIST	
 * Quellen: MART_MSI:t_bo_base_performance_list_2 (alleinige Basisstruktur)	
 * direkte Quelle:   MART_MSI:v_bo_performance_list_day_2	
 * Relevante Measure-Values werden ermittelt. Es findet kein Ranking statt.	
 *	
 * Granularität (Gewinnerstore, Woche_2) - keine weitere Verdichtung	
 ************************************************************************* */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_bo_performance_list_day_tot_2 AS SELECT client_id,
 store_id,
 MAX(orig_store_nr) AS orig_store_nr,
 MAX(store_desc) AS store_desc,
 MAX(city) AS city,
 MAX(wh_id) AS wh_id,
 MAX(wh_desc) AS wh_desc,
 MAX(sales_manager_id) AS sales_manager_id,
 MAX(sales_manager_name) AS sales_manager_name,
 MAX(account_manager_id) AS account_manager_id,
 MAX(account_manager_name) AS account_manager_name,
 cy_week,
 MAX(currency_iso_cd) AS currency_iso_cd,
 SUM(plan_val_turnover) AS plan_val_turnover,
 SUM(plan_val_turnover_net) AS plan_val_turnover_net,
 SUM(plan_val_hours) AS plan_val_hours,
 SUM(plan_val_inv_training) AS plan_val_inv_training,
 SUM(val_retail_asis) AS val_retail_asis,
 SUM(val_retail_net_asis) AS val_retail_net_asis,
 SUM(cnt_customer_asis) AS cnt_customer_asis,
 SUM(time_working_netto_std) AS time_working_netto_std,
 COALESCE(SUM(miss_times_perf), 0) AS miss_times_perf,
    (ROUND(CAST(SUM(val_retail_asis) AS NUMERIC), 4) - SUM(plan_turnover_calc_ums_diff)) / IF(SUM(plan_turnover_calc_ums_diff
      ) = 0, NULL, SUM(plan_turnover_calc_ums_diff)) * 100 AS diff_val_retail_pct,
    (SUM(val_retail_net_asis) - SUM(plan_turnover_calc_ums_dif_net)) / IF(SUM(plan_turnover_calc_ums_dif_net) = 0, NULL
    , SUM(plan_turnover_calc_ums_dif_net)) * 100 AS diff_val_retail_net_pct,
   SUM(time_working_netto_std) + COALESCE(SUM(miss_times_perf), 0) - SUM(plan_hours_calc_hrs_diff) AS diff_hours,
  SUM(plan_val_turnover) / IF(SUM(plan_val_hours) = 0, NULL, SUM(plan_val_hours)) AS plan_productivity,
  CAST(SUM(plan_val_turnover_net) AS NUMERIC) / IF(SUM(plan_val_hours) = 0, NULL, SUM(plan_val_hours)) AS
 plan_productivity_net,
  SUM(plan_turnover_calc_prod_diff) / IF(SUM(plan_hours_calc_prod_diff) = 0, NULL, SUM(plan_hours_calc_prod_diff)) AS
 plan_productivity_calc,
  CAST(SUM(plan_turnover_calc_pro_dif_net) AS NUMERIC) / IF(SUM(plan_hours_calc_prod_diff) = 0, NULL, SUM(plan_hours_calc_prod_diff
    )) AS plan_productivity_net_calc,
  CAST(SUM(val_retail_calc_prod_diff) AS NUMERIC) / IF(SUM(hrs_calc_prod_diff) + COALESCE(SUM(miss_times_perf_calc_prod_diff
       ), 0) = 0, NULL, SUM(hrs_calc_prod_diff) + COALESCE(SUM(miss_times_perf_calc_prod_diff), 0)) AS act_productivity
 ,
  SUM(val_retail_calc_prod_diff_net) / IF(SUM(hrs_calc_prod_diff) + COALESCE(SUM(miss_times_perf_calc_prod_diff), 0) = 0
    , NULL, SUM(hrs_calc_prod_diff) + COALESCE(SUM(miss_times_perf_calc_prod_diff), 0)) AS act_productivity_net,
   CAST(SUM(val_retail_calc_prod_diff) AS NUMERIC) / IF(SUM(hrs_calc_prod_diff) + COALESCE(SUM(miss_times_perf_calc_prod_diff
        ), 0) = 0, NULL, SUM(hrs_calc_prod_diff) + COALESCE(SUM(miss_times_perf_calc_prod_diff), 0)) - SUM(plan_turnover_calc_prod_diff
    ) / IF(SUM(plan_hours_calc_prod_diff) = 0, NULL, SUM(plan_hours_calc_prod_diff)) AS diff_plan_act_productivity,
   SUM(val_retail_calc_prod_diff_net) / IF(SUM(hrs_calc_prod_diff) + COALESCE(SUM(miss_times_perf_calc_prod_diff), 0) =
     0, NULL, SUM(hrs_calc_prod_diff) + COALESCE(SUM(miss_times_perf_calc_prod_diff), 0)) - CAST(SUM(plan_turnover_calc_pro_dif_net) AS NUMERIC)
   / IF(SUM(plan_hours_calc_prod_diff) = 0, NULL, SUM(plan_hours_calc_prod_diff)) AS diff_plan_act_productivity_net
FROM ldl_p_lew_mart_msi.v_bo_performance_list_day_2
GROUP BY client_id,
 store_id,
 cy_week;
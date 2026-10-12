CREATE OR REPLACE VIEW ldl_data_production_meta.v_dv_turnover_by_store_day_vs_planned_turnover_discrepancy (bus_dt,
int_org_sid, dwh_valid_from_tmsp, curr_int_org_nr, int_org_name, country_name, city_name, turnover_net_val,
planned_kpi_meas, turnover_plus_six_percent, turnover_minus_six_percent, failed_turnover_discrepancy, total)
OPTIONS(DESCRIPTION = `TURNOVER_NET_VAL FROM T_FACT_RETAIL_BY_STORE_DAY JOINED WITH PLANNED TURNOVER FROM T_PLAN_BY_DAY WITH CALCULATED DISCREPANCY +-6%\\NINPUT DATASETS:\\NCORE_DIM.T_FACT_RETAIL_BY_STORE_DAY\\NCORE_REL.T_PLAN_BY_DAY\\NCORE_DIM.T_DIM_INTERNAL_ORGANIZATION`)
AS SELECT fact.bus_dt,
 fact.int_org_sid,
 store.dwh_valid_from_tmsp,
 store.curr_int_org_nr,
 store.int_org_name,
 store.country_name,
 store.city_name,
 fact.turnover_net_val,
 plan.planned_kpi_meas,
  fact.turnover_net_val + fact.turnover_net_val / 100 * 6 AS turnover_plus_six_percent,
  fact.turnover_net_val - fact.turnover_net_val / 100 * 6 AS turnover_minus_six_percent,
  CASE
  WHEN plan.planned_kpi_meas BETWEEN fact.turnover_net_val - fact.turnover_net_val / 100 * 6 AND (fact.turnover_net_val
     + fact.turnover_net_val / 100 * 6)
  THEN 0
  ELSE 1
  END AS failed_turnover_discrepancy,
 1 AS total
FROM ldl_data_production_core_dim.t_fact_retail_by_store_day AS fact
 INNER JOIN ldl_data_production_core_rel.t_plan_by_day AS plan ON fact.int_org_sid = plan.int_org_sid AND fact.bus_dt =
   plan.cal_dt
 INNER JOIN ldl_data_production_core_dim.t_dim_internal_organization AS store ON fact.int_org_sid = store.int_org_sid
  AND fact.bus_dt BETWEEN CAST(store.dwh_valid_from_tmsp AS DATE) AND (CAST(store.dwh_valid_to_tmsp AS DATE))
WHERE plan.dwh_node_cd = 'CSV'
 AND plan.dwh_valid_fg
 AND fact.bus_dt < CURRENT_DATE;
create or replace view LDL_DATA_PRODUCTION.META.V_DV_TURNOVER_BY_STORE_DAY_VS_PLANNED_TURNOVER_DISCREPANCY_2(
	BUS_DT,
	INT_ORG_SID,
	DWH_VALID_FROM_TMSP,
	CURR_INT_ORG_NR,
	INT_ORG_NAME,
	COUNTRY_NAME,
	CITY_NAME,
	TURNOVER_NET_VAL,
	PLANNED_KPI_MEAS,
	TURNOVER_PLUS_SIX_PERCENT,
	TURNOVER_MINUS_SIX_PERCENT,
	FAILED_TURNOVER_DISCREPANCY,
	TOTAL
) COMMENT='Turnover_net_val from t_fact_retail_by_store_day_2 joined with planned turnover from t_plan_by_day_2 with calculated discrepancy +-6%\ninput datasets:\ncore_dim.t_fact_retail_by_store_day_2\ncore_rel.t_plan_by_day_2\ncore_dim.t_dim_internal_organization_2'
 as select fact.bus_dt, fact.int_org_sid, store.dwh_valid_from_tmsp, store.curr_int_org_nr, store.int_org_name, store.country_name, store.city_name, fact.turnover_net_val, plan.planned_kpi_meas, fact.turnover_net_val + (fact.turnover_net_val / 100 * 6) as turnover_plus_six_percent, fact.turnover_net_val - (fact.turnover_net_val / 100 * 6) as turnover_minus_six_percent, CASE WHEN (plan.planned_kpi_meas between turnover_minus_six_percent and turnover_plus_six_percent) THEN 0 ELSE 1 END AS failed_turnover_discrepancy, 1 AS TOTAL from core_dim.t_fact_retail_by_store_day_2 fact join core_rel.t_plan_by_day_2 plan on plan.int_org_sid = fact.int_org_sid and plan.cal_dt = fact.bus_dt join core_dim.t_dim_internal_organization_2 store on store.int_org_sid = fact.int_org_sid and fact.bus_dt between store.dwh_valid_from_tmsp and store.dwh_valid_to_tmsp where plan.dwh_node_cd = 'CSV' and plan.dwh_valid_fg = true and fact.bus_dt < current_date();
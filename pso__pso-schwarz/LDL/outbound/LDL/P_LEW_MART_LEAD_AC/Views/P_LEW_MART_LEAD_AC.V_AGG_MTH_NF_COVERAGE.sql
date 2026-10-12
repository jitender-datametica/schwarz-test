CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_mth_nf_coverage (client_id, country_group_id,
cy_week_partial_week_id, month_id, byr, currency_iso_cd, stock_mth_asis, stock_mth_py, revenue_mth_asis, revenue_mth_py
, revenue_sum_cy_asis, revenue_sum_py, revenue_sum_plan_cy, revenue_sum_plan_yr_py, revenue_plan_mth_asis,
revenue_plan_mth_py, revenue_plan_next_mth, revenue_plan_next_mth_py, coverage_cy, coverage_py, coverage_delta) AS
SELECT *
FROM ldl_p_lew_mart_lead.v_agg_mth_nf_coverage;
CREATE OR REPLACE VIEW p_lew_mart_lead_ac.v_agg_wh_month_costs_logistic_total_1
AS
(SELECT
client_id,
cy_month,
wh_id,
currency_iso_cd,
curr_tot_id,
current_year_act_val,
current_year_plan_val,
prev_year_act_val
FROM p_lew_mart_lead.v_agg_wh_month_costs_logistic_total_1
)
;
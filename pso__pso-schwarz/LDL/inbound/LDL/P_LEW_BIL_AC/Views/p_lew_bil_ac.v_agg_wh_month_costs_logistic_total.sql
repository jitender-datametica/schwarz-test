CREATE OR REPLACE VIEW p_lew_bil_ac.v_agg_wh_month_costs_logistic_total
AS
(SELECT
client_id,
cy_month,
wh_id,
currency_iso_cd,
current_year_act_val,
current_year_plan_val,
prev_year_act_val
FROM p_lew_bil.v_agg_wh_month_costs_logistic_total
)
;
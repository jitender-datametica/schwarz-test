CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_agg_country_month_costs_logistic_total_2 AS -- Um Zeitdimension erweirtert

SELECT AGG.client_id,
 AGG.cy_month,
 AGG.currency_iso_cd,
 REF_CUR.curr_tot_id,
 SUM(AGG.current_year_act_val) AS current_year_act_val,
 SUM(AGG.current_year_plan_val) AS current_year_plan_val,
 SUM(AGG.prev_year_act_val) AS prev_year_act_val
FROM ldl_p_lew_bil_ac.v_agg_wh_month_costs_logistic_total_2 AS AGG
 INNER JOIN ldl_p_lew_mart_lead_ac.v_ref_currency_2 AS REF_CUR ON AGG.client_id = REF_CUR.client_id AND AGG.currency_iso_cd
    = REF_CUR.currency_iso_cd
GROUP BY AGG.client_id,
 AGG.cy_month,
 AGG.currency_iso_cd,
 REF_CUR.curr_tot_id;
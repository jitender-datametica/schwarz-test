CREATE OR REPLACE VIEW p_lew_mart_lead.v_agg_country_month_costs_logistic_total
AS
(SELECT
agg.client_id,
agg.cy_month    -- Um Zeitdimension erweirtert
,
agg.currency_iso_cd,
ref_cur.curr_tot_id,
SUM (agg.current_year_act_val     ) AS current_year_act_val,
SUM (agg.current_year_plan_val    ) AS current_year_plan_val,
SUM (agg.prev_year_act_val        ) AS prev_year_act_val
FROM p_lew_bil_ac.v_agg_wh_month_costs_logistic_total agg
INNER JOIN p_lew_mart_lead_ac.v_ref_currency ref_cur ON agg.client_id = ref_cur.client_id AND agg.currency_iso_cd = ref_cur.currency_iso_cd
GROUP BY agg.client_id, agg.cy_month, agg.currency_iso_cd, ref_cur.curr_tot_id
)
;
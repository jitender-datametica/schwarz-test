CREATE OR REPLACE VIEW ldl_p_lew_bil.v_agg_wh_month_costs_logistic_total_2 AS SELECT client_id,
 cy_month,
 wh_id,
 curr_cd AS currency_iso_cd,
 SUM(current_year_act_val_) AS current_year_act_val,
 SUM(current_year_plan_val_) AS current_year_plan_val,
 SUM(prev_year_act_val_) AS prev_year_act_val
FROM (SELECT client_id,
    country_cd,
    wh_id,
    loc_sid,
    cy_month,
    curr_cd,
    CAST(current_year_act_val AS NUMERIC) AS current_year_act_val_,
    CAST(current_year_plan_val AS NUMERIC) AS current_year_plan_val_,
    CAST(prev_year_act_val AS NUMERIC) AS prev_year_act_val_
   FROM ldl_p_lew_precore_ac.v_cache_metric_logistics_warehouse_month_hist_2 AS LWH
   WHERE deleted_fg = 0
    AND CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
   GROUP BY client_id,
    country_cd,
    wh_id,
    loc_sid,
    cy_month,
    curr_cd,
    current_year_act_val_,
    current_year_plan_val_,
    prev_year_act_val_
   UNION ALL
   SELECT LWH.client_id,
    LWH.country_cd,
    LWH.wh_id,
    LWH.loc_sid,
    LWH.cy_month,
    B.curr_cd_from AS curr_cd,
    CAST(LWH.current_year_act_val / B.exchange_rate AS NUMERIC) AS current_year_act_val_,
    CAST(LWH.current_year_plan_val / B.exchange_rate AS NUMERIC) AS current_year_plan_val_,
    CAST(LWH.prev_year_act_val / B.exchange_rate AS NUMERIC) AS prev_year_act_val_
   FROM ldl_p_lew_precore_ac.v_cache_metric_logistics_warehouse_month_hist_2 AS LWH
    INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_known_hist_2 AS B ON LWH.client_id = B.client_id AND LWH.curr_cd = B.curr_cd_to
           AND CURRENT_DATE BETWEEN B.active_from_dt AND B.active_to_dt AND CURRENT_DATE BETWEEN B.dwh_valid_from AND B
        .dwh_valid_to AND (LWH.client_id <> 15 AND B.curr_cd_from = 'EUR' OR LWH.client_id = 15 AND B.curr_cd_from =
          'HRK') AND LWH.deleted_fg = 0
    INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_2 AS C ON B.client_id = C.client_id AND B.x_rate_type_sid = C.x_rate_type_sid
        AND C.src_kurst = '@BEWE'
   WHERE LWH.deleted_fg = 0
    AND CURRENT_DATE BETWEEN LWH.dwh_valid_from AND LWH.dwh_valid_to
    AND (LWH.client_id = 15 AND LWH.curr_cd = 'EUR' OR LWH.curr_cd <> 'EUR' AND LWH.client_id <> 15)
   GROUP BY LWH.client_id,
    LWH.country_cd,
    LWH.wh_id,
    LWH.loc_sid,
    LWH.cy_month,
    curr_cd,
    current_year_act_val_,
    current_year_plan_val_,
    prev_year_act_val_) AS agg
GROUP BY client_id,
 cy_month,
 wh_id,
 currency_iso_cd;
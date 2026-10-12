CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_stat_order_wk_work_2 (client_id, cy_week, currency_iso_cd, curr_tot_id
, order_cnt_stationary, order_lin_cnt_stationary, turnover_net_val_stationary, plan_turnover_net_val_stationary) AS
SELECT *
FROM ldl_p_lew_mart_lead.v_agg_stat_order_wk_work_2;
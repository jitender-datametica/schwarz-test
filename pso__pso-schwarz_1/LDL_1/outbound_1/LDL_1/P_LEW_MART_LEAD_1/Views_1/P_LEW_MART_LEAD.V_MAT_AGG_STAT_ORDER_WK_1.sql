-- Abverkauf_Umsatz
 -- Kunden
 -- Kunden
 -- Umsatz_Plan
 -- Umsatz_EJR
 -- Abverkauf_Umsatz
 -- Umsatz_EJR

CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_mat_agg_stat_order_wk_1 (client_id, cy_week, py_week, currency_iso_cd,
curr_tot_id, order_cnt_stationary_wk, order_lin_cnt_stationary_wk, turnover_net_val_stationary_wk,
plan_turnover_net_val_stationary_wk, order_cnt_stationary_pyw, order_lin_cnt_stationary_pyw,
turnover_net_val_stationary_pyw) AS -- Kunden
 -- Abverkauf_Umsatz
 -- Umsatz_EJR
 -- Umsatz_Plan
 -- Kunden

-- Abverkauf_Umsatz
 -- Umsatz_EJR
 SELECT WORK1.client_id,
 WORK1.cy_week,
 WORK2.cy_week AS py_week,
 WORK1.currency_iso_cd,
 WORK1.curr_tot_id,
 WORK1.order_cnt_stationary AS order_cnt_stationary_wk,
 WORK1.order_lin_cnt_stationary AS order_lin_cnt_stationary_wk,
 WORK1.turnover_net_val_stationary AS turnover_net_val_stationary_wk,
 WORK1.plan_turnover_net_val_stationary AS plan_turnover_net_val_stationary_wk,
 WORK2.order_cnt_stationary AS order_cnt_stationary_pyw,
 WORK2.order_lin_cnt_stationary AS order_lin_cnt_stationary_pyw,
 WORK2.turnover_net_val_stationary AS turnover_net_val_stationary_pyw
FROM ldl_p_lew_mart_lead_ac.v_agg_stat_order_wk_work_1 AS WORK1
 LEFT JOIN ldl_p_lew_mart_lead_ac.v_agg_stat_order_wk_work_1 AS WORK2 ON WORK1.client_id = WORK2.client_id AND WORK1.cy_week
       - 100 = WORK2.cy_week AND WORK1.currency_iso_cd = WORK2.currency_iso_cd AND WORK1.curr_tot_id = WORK2.curr_tot_id;
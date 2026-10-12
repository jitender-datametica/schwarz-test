-- Kunden
 -- Abverkauf_Umsatz
 -- Umsatz_EJR
 -- Kunden
 -- Umsatz_EJR
 -- Umsatz_Plan
 -- Abverkauf_Umsatz

CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_mat_agg_stat_order_mth (client_id, cy_month, py_month, currency_iso_cd,
curr_tot_id, order_cnt_stationary_mth, order_lin_cnt_stationary_mth, turnover_net_val_stationary_mth,
plan_turnover_net_val_stationary_mth, order_cnt_stationary_pym, order_lin_cnt_stationary_pym,
turnover_net_val_stationary_pym) AS -- Kunden
 -- Abverkauf_Umsatz
 -- Umsatz_EJR
 -- Umsatz_Plan
 -- Kunden

-- Abverkauf_Umsatz
 -- Umsatz_EJR
 SELECT WORK1.client_id,
 WORK1.cy_month,
 WORK2.cy_month AS py_month,
 WORK1.currency_iso_cd,
 WORK1.curr_tot_id,
 WORK1.order_cnt_stationary AS order_cnt_stationary_mth,
 WORK1.order_lin_cnt_stationary AS order_lin_cnt_stationary_mth,
 WORK1.turnover_net_val_stationary AS turnover_net_val_stationary_mth,
 WORK1.plan_turnover_net_val_stationary AS plan_turnover_net_val_stationary_mth,
 WORK2.order_cnt_stationary AS order_cnt_stationary_pym,
 WORK2.order_lin_cnt_stationary AS order_lin_cnt_stationary_pym,
 WORK2.turnover_net_val_stationary AS turnover_net_val_stationary_pym
FROM ldl_p_lew_mart_lead_ac.v_agg_stat_order_mth_work AS WORK1
 LEFT JOIN ldl_p_lew_mart_lead_ac.v_agg_stat_order_mth_work AS WORK2 ON WORK1.client_id = WORK2.client_id AND WORK1.cy_month
       - 100 = WORK2.cy_month AND WORK1.currency_iso_cd = WORK2.currency_iso_cd AND WORK1.curr_tot_id = WORK2.curr_tot_id;
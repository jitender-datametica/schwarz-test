CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital_ac.v_agg_ldi_order_wk_2 (client_id, client_id_online, cy, cy_week,
currency_iso_cd, curr_tot_id, order_cnt_wk, order_line_cnt_wk, turnover_net_val_wk, plan_turnover_net_val_wk,
order_cnt_pyw, order_line_cnt_pyw, turnover_net_val_pyw) AS SELECT *
FROM ldl_p_lew_mart_lidl_digital.v_agg_ldi_order_wk_2;
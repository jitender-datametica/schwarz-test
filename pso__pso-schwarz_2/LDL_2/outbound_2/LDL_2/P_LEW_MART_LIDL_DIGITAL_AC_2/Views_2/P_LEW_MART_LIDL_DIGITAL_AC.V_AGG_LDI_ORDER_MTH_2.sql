CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital_ac.v_agg_ldi_order_mth_2 (client_id, client_id_online, cy, cy_month,
currency_iso_cd, curr_tot_id, order_cnt_mth, order_line_cnt_mth, turnover_net_val_mth, plan_turnover_net_val_mth,
order_cnt_pym, order_line_cnt_pym, turnover_net_val_pym) AS SELECT *
FROM ldl_p_lew_mart_lidl_digital.v_agg_ldi_order_mth_2;
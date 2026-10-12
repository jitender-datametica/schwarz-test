CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital_ac.v_agg_ldi_order_day_1 (client_id, client_id_online, cy, dat_calendar
, currency_iso_cd, curr_tot_id, order_cnt_day, order_line_cnt_day, turnover_net_val_day, plan_turnover_net_val_day,
order_cnt_pyd, order_line_cnt_pyd, turnover_net_val_pyd) AS SELECT *
FROM ldl_p_lew_mart_lidl_digital.v_agg_ldi_order_day_1;
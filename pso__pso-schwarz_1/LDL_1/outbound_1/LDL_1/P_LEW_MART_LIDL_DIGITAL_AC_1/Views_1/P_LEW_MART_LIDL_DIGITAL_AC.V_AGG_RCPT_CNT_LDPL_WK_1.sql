CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital_ac.v_agg_rcpt_cnt_ldpl_wk_1 (client_id, wh_id, move_to_store_id,
aspect_id, cy_week, store_tot_rcpt, store_lp_rcpt, wh_tot_rcpt, wh_lp_rcpt, client_tot_rcpt, client_lp_rcpt) AS SELECT *
 
FROM ldl_p_lew_mart_lidl_digital.v_agg_rcpt_cnt_ldpl_wk_1;
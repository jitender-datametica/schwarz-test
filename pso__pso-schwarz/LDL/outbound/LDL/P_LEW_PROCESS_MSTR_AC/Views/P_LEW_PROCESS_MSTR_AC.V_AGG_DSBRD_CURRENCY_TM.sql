CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_agg_dsbrd_currency_tm (client_id, currency_iso_cd, curr_tot_id,
tm_lvl_id, cy_week, cy_month, dummytime) AS SELECT *
FROM ldl_p_lew_process_mstr.v_agg_dsbrd_currency_tm;
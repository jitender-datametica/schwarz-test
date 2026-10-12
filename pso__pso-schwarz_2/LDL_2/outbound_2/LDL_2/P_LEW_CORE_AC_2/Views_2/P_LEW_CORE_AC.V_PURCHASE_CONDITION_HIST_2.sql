CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_purchase_condition_hist_2 (client_id, pur_cond_sid, curr_sid, condition_pos_nr
, curr_cd, condition_val, condition_pct_val, deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created,
dwh_updated) AS SELECT client_id,
 pur_cond_sid,
 curr_sid,
 condition_pos_nr,
 curr_cd,
 condition_val,
 condition_pct_val,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_purchase_condition_hist_2;
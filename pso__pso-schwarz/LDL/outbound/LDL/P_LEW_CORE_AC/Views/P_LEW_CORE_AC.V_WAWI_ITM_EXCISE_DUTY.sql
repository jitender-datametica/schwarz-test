CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_itm_excise_duty (client_id, item_sid, main_exduty, sub_exduty,
dat_rec_start, dat_rec_end, dat_valid_from, dat_valid_until, pct_exc_duty, load_id) AS SELECT client_id,
 item_sid,
 main_exduty,
 sub_exduty,
 dat_rec_start,
 dat_rec_end,
 dat_valid_from,
 dat_valid_until,
 pct_exc_duty,
 load_id
FROM ldl_p_lew_core.t_wawi_itm_excise_duty;
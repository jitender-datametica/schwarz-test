CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_lil_period (client_id, period_sid, period_id, period_lvl,
liam_avbl_fg, lift_avbl_fg, active_fg, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 period_sid,
 period_id,
 period_lvl,
 liam_avbl_fg,
 lift_avbl_fg,
 active_fg,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_process_mstr.t_lil_period;
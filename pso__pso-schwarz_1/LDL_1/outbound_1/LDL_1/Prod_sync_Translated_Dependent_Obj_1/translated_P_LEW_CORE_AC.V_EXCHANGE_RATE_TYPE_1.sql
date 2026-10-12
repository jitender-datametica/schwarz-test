CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_exchange_rate_type_1 (client_id, x_rate_type_sid, src_kurst, curr_sid,
x_rate_type_name, curr_cd, fixed_rate_fg, special_rate_fg, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 x_rate_type_sid,
 src_kurst,
 curr_sid,
 x_rate_type_name,
 curr_cd,
 fixed_rate_fg,
 special_rate_fg,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_exchange_rate_type_1;
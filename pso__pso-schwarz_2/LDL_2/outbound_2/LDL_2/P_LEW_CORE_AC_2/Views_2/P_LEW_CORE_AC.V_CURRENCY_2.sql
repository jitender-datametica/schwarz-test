CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_currency_2 (client_id, curr_sid, src_waers, curr_name, curr_iso_cd, curr_dec,
factor, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 curr_sid,
 src_waers,
 curr_name,
 curr_iso_cd,
 curr_dec,
 factor,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_currency_2;
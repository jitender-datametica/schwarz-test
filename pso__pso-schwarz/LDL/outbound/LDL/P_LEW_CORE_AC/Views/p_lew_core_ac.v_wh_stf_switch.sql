CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wh_stf_switch (client_id, wh_id, loc_sid_wh, stf_sfo_switch_fg, switch_date,
dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 wh_id,
 loc_sid_wh,
 stf_sfo_switch_fg,
 switch_date,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_wh_stf_switch;
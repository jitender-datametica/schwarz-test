CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_lil_retailer_period (client_id, retailer_sid, period_sid, retailer_sid_parent
, interface_name, deleted_fg, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 retailer_sid,
 period_sid,
 retailer_sid_parent,
 interface_name,
 deleted_fg,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_lil_retailer_period;
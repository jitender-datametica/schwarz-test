CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_ldpl_client_id (client_id, deleted_fg, dwh_valid_from, dwh_valid_to,
dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_mart_lead.t_ldpl_client_id;
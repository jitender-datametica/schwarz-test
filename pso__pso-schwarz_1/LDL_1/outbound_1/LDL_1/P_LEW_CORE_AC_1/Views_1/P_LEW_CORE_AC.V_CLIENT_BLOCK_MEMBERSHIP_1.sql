CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_client_block_membership_1 (client_block_id, client_id_member,
cy_week_deliver_from, cy_week_deliver_to, cy_week_advertise_from, dwh_load_id, dwh_created, dwh_updated) AS SELECT
 client_block_id,
 client_id_member,
 cy_week_deliver_from,
 cy_week_deliver_to,
 cy_week_advertise_from,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_client_block_membership_1;
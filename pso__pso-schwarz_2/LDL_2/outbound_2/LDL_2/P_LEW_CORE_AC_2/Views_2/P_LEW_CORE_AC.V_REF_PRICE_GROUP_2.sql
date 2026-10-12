CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_price_group_2 (client_id, price_group_id, price_group_name,
price_group_prio, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 price_group_id,
 price_group_name,
 price_group_prio,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_price_group_2;
CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_price_label_producer_1 (price_label_producer_name, dwh_load_id, dwh_created
, dwh_updated) AS SELECT price_label_producer_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_price_label_producer_1;
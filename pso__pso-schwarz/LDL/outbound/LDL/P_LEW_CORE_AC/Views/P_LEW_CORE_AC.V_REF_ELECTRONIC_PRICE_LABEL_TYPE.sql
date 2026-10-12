CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_electronic_price_label_type (electronic_price_label_type_cd,
price_label_producer_name, dwh_load_id, dwh_created, dwh_updated) AS SELECT electronic_price_label_type_cd,
 price_label_producer_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_electronic_price_label_type;
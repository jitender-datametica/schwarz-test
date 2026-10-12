CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_price_label_2 (client_id, price_label_sid, price_label_nr,
electronic_price_label_type_cd, price_label_producer_name, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 price_label_sid,
 price_label_nr,
 electronic_price_label_type_cd,
 price_label_producer_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_price_label_2;
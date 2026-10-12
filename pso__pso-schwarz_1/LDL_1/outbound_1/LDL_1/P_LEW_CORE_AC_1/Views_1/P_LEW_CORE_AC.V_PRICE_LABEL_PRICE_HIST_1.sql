CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_price_label_price_hist_1 (electronic_price_label_type_cd,
price_label_producer_name, curr_iso_cd, net_price, deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created,
dwh_updated) AS SELECT electronic_price_label_type_cd,
 price_label_producer_name,
 curr_iso_cd,
 net_price,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_price_label_price_hist_1;
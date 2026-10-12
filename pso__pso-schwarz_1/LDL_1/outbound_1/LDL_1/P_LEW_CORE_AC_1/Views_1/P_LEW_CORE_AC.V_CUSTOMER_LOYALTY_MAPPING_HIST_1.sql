CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_customer_loyalty_mapping_hist_1 (client_id, customer_sid, loyalty_cd,
ident_type_cd, mapping_start_tmsp, mapping_end_tmsp, deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created
, dwh_updated) AS SELECT client_id,
 customer_sid,
 loyalty_cd,
 ident_type_cd,
 mapping_start_tmsp,
 mapping_end_tmsp,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_customer_loyalty_mapping_hist_1;
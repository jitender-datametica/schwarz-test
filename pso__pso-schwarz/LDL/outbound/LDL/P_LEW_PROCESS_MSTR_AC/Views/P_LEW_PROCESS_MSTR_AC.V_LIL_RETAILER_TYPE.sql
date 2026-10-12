CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_lil_retailer_type (rtl_tp_id, rtl_tp_desc, dwh_load_id, dwh_created,
dwh_updated) AS SELECT rtl_tp_id,
 rtl_tp_desc,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_process_mstr.t_lil_retailer_type;
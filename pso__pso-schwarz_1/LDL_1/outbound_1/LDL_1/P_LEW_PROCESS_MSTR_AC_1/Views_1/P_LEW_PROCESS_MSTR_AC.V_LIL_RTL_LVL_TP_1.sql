CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_lil_rtl_lvl_tp_1 (rtl_lvl, rtl_tp_id, dwh_load_id, dwh_created,
dwh_updated) AS SELECT rtl_lvl,
 rtl_tp_id,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_process_mstr.t_lil_rtl_lvl_tp_1;
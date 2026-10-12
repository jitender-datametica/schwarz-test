CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_lil_lift_dm_retailer_gd_sort_2 (client_id, rtl_id, rtl_desc,
rtl_desc_en, rtl_tp_id, clnt_rtl_srt_cd) AS SELECT client_id,
 rtl_id,
 rtl_desc,
 rtl_desc_en,
 rtl_tp_id,
 clnt_rtl_srt_cd
FROM ldl_p_lew_process_mstr.t_lil_lift_dm_retailer_gd_sort_2;
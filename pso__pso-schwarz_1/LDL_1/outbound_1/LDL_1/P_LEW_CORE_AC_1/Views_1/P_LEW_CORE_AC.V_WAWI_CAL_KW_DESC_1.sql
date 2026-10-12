CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_cal_kw_desc_1 (language_id, kw_name, kw_name_short) AS SELECT language_id
 ,
 kw_name,
 kw_name_short
FROM ldl_p_lew_core.t_wawi_cal_kw_desc_1;
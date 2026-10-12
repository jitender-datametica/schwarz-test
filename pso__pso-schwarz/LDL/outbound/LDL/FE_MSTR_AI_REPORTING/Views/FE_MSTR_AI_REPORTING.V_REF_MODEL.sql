CREATE OR REPLACE VIEW ldl_fe_mstr_ai_reporting.v_ref_model (model_sid, model_group_cd, model_area_cd, model_name,
model_descr) AS SELECT model_sid,
 model_group_cd,
 model_area_cd,
 model_name,
 model_descr
FROM ldl_p_lew_core.t_ref_model;
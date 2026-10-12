CREATE OR REPLACE VIEW ldl_fe_mstr_ai_reporting.v_item_store_model_score_1 (client_id, model_sid, model_run_dt, loc_sid,
item_sid, score_type_sid, score_meas, model_area_cd, model_group_cd, aspect_id) AS SELECT client_id,
 model_sid,
 model_run_dt,
 loc_sid,
 item_sid,
 score_type_sid,
 score_meas,
 model_area_cd,
 model_group_cd,
 1 AS aspect_id
FROM ldl_p_lew_core.t_item_store_model_score_1;
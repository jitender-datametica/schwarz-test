CREATE OR REPLACE VIEW ldl_fe_mstr_ai_reporting.v_bak_agg_item_store_day_model_prediction_2 (client_id, model_sid,
model_run_dt, loc_sid, item_sid, prediction_dt, score_type_sid, score_meas, model_area_cd, model_group_cd, dwh_load_id,
dwh_created, dwh_updated, aspect_id, meas_count) AS SELECT client_id,
 model_sid,
 model_run_dt,
 loc_sid,
 item_sid,
 prediction_dt,
 score_type_sid,
 score_meas,
 model_area_cd,
 model_group_cd,
 dwh_load_id,
 dwh_created,
 dwh_updated,
 1 AS aspect_id,
 1 AS meas_count
FROM ldl_p_lew_core.t_item_store_day_model_score_2 AS SC
WHERE model_sid = 2
 AND score_type_sid IN (5, 6, 7)
 AND (FORMAT_DATE('%a', model_run_dt) IN ('Wed', 'Fri') OR model_run_dt = DATE '2025-05-22');
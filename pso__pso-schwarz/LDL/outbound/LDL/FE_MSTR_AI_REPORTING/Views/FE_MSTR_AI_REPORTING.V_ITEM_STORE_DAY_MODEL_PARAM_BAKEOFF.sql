CREATE OR REPLACE VIEW ldl_fe_mstr_ai_reporting.v_item_store_day_model_param_bakeoff (client_id, model_sid, model_run_dt
, loc_sid, item_sid, prediction_dt, price_change_fg, item_reference_sid, model_area_cd, model_group_cd, aspect_id) AS
SELECT client_id,
 model_sid,
 model_run_dt,
 loc_sid,
 item_sid,
 prediction_dt,
 price_change_fg,
 item_reference_sid,
 model_area_cd,
 model_group_cd,
 1 AS aspect_id
FROM ldl_p_lew_core.t_item_store_day_model_param_bakeoff;
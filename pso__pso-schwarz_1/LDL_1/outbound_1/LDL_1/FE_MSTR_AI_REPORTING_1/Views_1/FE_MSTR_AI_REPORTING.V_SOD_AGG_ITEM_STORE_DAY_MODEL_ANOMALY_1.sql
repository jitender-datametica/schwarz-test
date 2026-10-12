CREATE OR REPLACE VIEW ldl_fe_mstr_ai_reporting.v_sod_agg_item_store_day_model_anomaly_1 (client_id, model_sid,
model_run_dt, loc_sid, item_sid, prediction_dt, score_type_sid, score_meas, model_area_cd, model_group_cd, dwh_load_id,
dwh_created, dwh_updated, aspect_id, meas_count) AS SELECT SC.client_id,
 SC.model_sid,
 SC.model_run_dt,
 SC.loc_sid,
 SC.item_sid,
 SC.prediction_dt,
 SC.score_type_sid,
 SC.score_meas,
 SC.model_area_cd,
 SC.model_group_cd,
 SC.dwh_load_id,
 SC.dwh_created,
 SC.dwh_updated,
 2 AS aspect_id,
 1 AS meas_count
FROM ldl_p_lew_core.t_item_store_day_model_score_1 AS SC
 INNER JOIN (SELECT ROW_NUMBER() OVER (PARTITION BY prediction_dt ORDER BY model_run_dt IS NULL DESC, model_run_dt DESC
    ) AS rn,
   model_run_dt,
   prediction_dt
  FROM ldl_p_lew_core.t_item_store_day_model_score_1
  GROUP BY model_run_dt,
   prediction_dt) AS RW ON SC.model_run_dt = RW.model_run_dt AND SC.prediction_dt = RW.prediction_dt
WHERE RW.rn = 1;
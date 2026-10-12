CREATE OR REPLACE VIEW ldl_fe_mstr_ai_reporting.v_sod_agg_item_store_day_model_velocity_2 (client_id, model_sid,
model_run_dt, item_sid, loc_sid, prediction_dt, segmentation_sid, segment_sid, model_area_cd, model_group_cd,
dwh_load_id, dwh_created, dwh_updated, aspect_id) AS SELECT SG.client_id,
 SG.model_sid,
 SG.model_run_dt,
 SG.item_sid,
 SG.loc_sid,
 SG.prediction_dt,
 SG.segmentation_sid,
 SG.segment_sid,
 SG.model_area_cd,
 SG.model_group_cd,
 SG.dwh_load_id,
 SG.dwh_created,
 SG.dwh_updated,
 2 AS aspect_id
FROM ldl_p_lew_core.t_item_store_day_model_segment_2 AS SG
 INNER JOIN (SELECT ROW_NUMBER() OVER (PARTITION BY prediction_dt ORDER BY model_run_dt IS NULL DESC, model_run_dt DESC
    ) AS rn,
   model_run_dt,
   prediction_dt
  FROM ldl_p_lew_core.t_item_store_day_model_segment_2
  WHERE segmentation_sid = 1
  GROUP BY model_run_dt,
   prediction_dt
  ORDER BY 3 NULLS LAST,
   1 NULLS LAST) AS RW ON SG.model_run_dt = RW.model_run_dt AND SG.prediction_dt = RW.prediction_dt
WHERE SG.segmentation_sid = 1
 AND RW.rn = 1;
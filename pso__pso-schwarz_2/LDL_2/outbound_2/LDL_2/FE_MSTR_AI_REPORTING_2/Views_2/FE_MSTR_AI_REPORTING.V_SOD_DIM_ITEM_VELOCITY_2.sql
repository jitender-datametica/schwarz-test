CREATE OR REPLACE VIEW ldl_fe_mstr_ai_reporting.v_sod_dim_item_velocity_2 (segment_sid, segmentation_sid, src_segment_nr,
segment_name_us, segment_descr, model_sid, model_area_cd, model_group_cd, dwh_load_id, dwh_created, dwh_updated,
lower_bound_meas, upper_bound_meas, segment_name) AS SELECT SEG.segment_sid,
 SEG.segmentation_sid,
 SEG.src_segment_nr,
 SEG.segment_name AS segment_name_us,
 SEG.segment_descr,
 SEG.model_sid,
 SEG.model_area_cd,
 SEG.model_group_cd,
 SEG.dwh_load_id,
 SEG.dwh_created,
 SEG.dwh_updated,
 SEG_H.lower_bound_meas,
 SEG_H.upper_bound_meas,
 CAST(CASE
   WHEN SEG.segment_name LIKE 'ult%a_slow'
   THEN 'sehr langsam'
   WHEN SEG.segment_name = 'slow'
   THEN 'langsam'
   WHEN SEG.segment_name = 'medium'
   THEN 'mittel'
   WHEN SEG.segment_name = 'fast'
   THEN 'schnell'
   ELSE 'nicht definiert'
   END AS STRING) AS segment_name
FROM ldl_p_lew_core.t_ref_segment_2 AS SEG
 INNER JOIN ldl_p_lew_core.t_ref_segment_hist_2 AS SEG_H ON SEG.segment_sid = SEG_H.segment_sid
WHERE SEG.model_sid = 1
 AND SEG.segmentation_sid = 1
 AND SEG_H.deleted_fg = 0
 AND CURRENT_DATE BETWEEN SEG_H.dwh_valid_from AND SEG_H.dwh_valid_to;
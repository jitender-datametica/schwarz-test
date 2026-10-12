CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_segment_2 (segment_sid OPTIONS(description='Surrogate Key SEGMENT.'),
src_segment_nr
OPTIONS(description='Identifier of the segment in the segmentation in the source system, same segment numbers may exist for different segmentations within the same model, and in different models.'),
segment_name OPTIONS(description='Name of the segment in the segmentation.'), segment_descr
OPTIONS(description='Description of the segment in the segmentation.'), segmentation_sid
OPTIONS(description='Surrogate Key SEGMENTATION.'), segmentation_name
OPTIONS(description='Name of the segmentation in the model.'), model_sid OPTIONS(description='Surrogate Key MODEL.'),
model_name OPTIONS(description='Name of the model.'), model_area_cd
OPTIONS(description='sprechender Code, CX, LDL+, AP.'), model_group_cd
OPTIONS(description='Eindeutiger Code, der mit dem area_cd beginnt z.b. AP_bakeoff oder CX_store_rating.'), dwh_load_id
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingefuegt oder veraendert hat.'), dwh_created
OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH.'), dwh_updated
OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH.')) AS SELECT segment_sid,
 src_segment_nr,
 segment_name,
 segment_descr,
 segmentation_sid,
 segmentation_name,
 model_sid,
 model_name,
 model_area_cd,
 model_group_cd,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_segment_2;
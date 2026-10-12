CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_segmentation (segmentation_sid
OPTIONS(description='Surrogate Key SEGMENTATION'), model_sid OPTIONS(description='Surrogate Key MODEL'),
segmentation_name OPTIONS(description='name of the segmentation in the model'), segmentation_descr
OPTIONS(description='description of the segmentatzion in the model'), dwh_load_id
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'), dwh_created
OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'), dwh_updated
OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH')) AS SELECT segmentation_sid,
 model_sid,
 segmentation_name,
 segmentation_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_segmentation;
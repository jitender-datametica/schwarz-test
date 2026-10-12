CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_model_model_run_metric (model_sid
OPTIONS(description='Surrogate Key MODEL'), model_run_metric_type_cd
OPTIONS(description='technical code for the metric to be calculated on model level in a run'), model_area_cd
OPTIONS(description='sprechender Code, CX, LDL+,AP'), model_group_cd
OPTIONS(description='eindeutiger code, der mit dem area_cd beginnt z.b. AP_bakeoff or CX_store_rating'), dwh_load_id
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'), dwh_created
OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'), dwh_updated
OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'))
OPTIONS(DESCRIPTION = `$Revision: 0000 $. THIS TABLE CONTAINS THE INFORMATION WHICH MODEL RUN METRIC WILL BE CALCULATED FOR WHICH MODEL`)
AS SELECT model_sid,
 model_run_metric_type_cd,
 model_area_cd,
 model_group_cd,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_model_model_run_metric;
CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_model_run_metric_2 (model_sid OPTIONS(description='Surrogate Key MODEL'),
geo_area_sid OPTIONS(description='Surrogate Key GEO AREA. Unique identifier of the geographical area.'), run_tmsp
OPTIONS(description='Relevant timestamp of the model run.'), active_from_dt
OPTIONS(description='Start of the timeframe the model run result is valid for. This is in general the first day of a reference period, e.g. the Monday of the reference week for a weekly model.'),
model_run_metric_type_cd OPTIONS(description='Technical code for the metric to be calculated on model level in a run.'),
model_run_metric_measure OPTIONS(description='Result of the calculation of the metric in a model run.'), model_area_cd
OPTIONS(description='Sprechender Code, CX, LDL+, AP.'), model_group_cd
OPTIONS(description='Eindeutiger code, der mit dem area_cd beginnt, z.B. AP_bakeoff or CX_store_rating.'), dwh_load_id
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingefügt oder verändert hat.'), dwh_created
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'), dwh_updated
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'))
OPTIONS(DESCRIPTION = `$Revision: 0000 $. THIS TABLE CONTAINS THE MODEL-LEVEL RESULTS OF A MODEL RUN FOR EVERY SPECIFIC MODEL RUN METRIC TYPE.`)
AS SELECT model_sid,
 geo_area_sid,
 run_tmsp,
 active_from_dt,
 model_run_metric_type_cd,
 model_run_metric_measure,
 model_area_cd,
 model_group_cd,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_model_run_metric_2;
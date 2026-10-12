CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_model_run_1 (model_sid OPTIONS(description='Surrogate Key MODEL'), geo_area_sid
OPTIONS(description='Surrogate Key GEO AREA. Unique identifier of the geographical area.'), run_tmsp
OPTIONS(description='Relevant timestamp of the model run.'), active_from_dt
OPTIONS(description='Start of the timeframe the model run result is valid for. This is in general the first day of a reference period, e.g. the Monday of the reference week for a weekly model.'),
active_to_dt
OPTIONS(description='End of the timeframe the model run result is valid for. This is in general the last day of a reference period, e.g. the Sunday of the reference week for a weekly model.'),
cy_week
OPTIONS(description='YYYYKW; WAWI: x_data.t_cal_week.cy_week. Populated in the case that the model is a weekly model.'),
cy_month
OPTIONS(description='YYYYMM; WAWI: x_data.t_cal_month.cy_month. Populated in the case that the model is a monthly model.'),
model_area_cd OPTIONS(description='Sprechender Code, CX, LDL+, AP.'), model_group_cd
OPTIONS(description='Eindeutiger code, der mit dem model_area_cd beginnt, z.B. AP_bakeoff or CX_store_rating.'),
dwh_load_id OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingefügt oder verändert hat.'),
dwh_created OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'), dwh_updated
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.')) AS SELECT model_sid,
 geo_area_sid,
 run_tmsp,
 active_from_dt,
 active_to_dt,
 cy_week,
 cy_month,
 model_area_cd,
 model_group_cd,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_model_run_1;
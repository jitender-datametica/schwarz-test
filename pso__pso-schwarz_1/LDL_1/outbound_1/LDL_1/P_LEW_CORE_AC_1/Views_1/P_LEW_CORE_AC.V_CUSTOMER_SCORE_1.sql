CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_customer_score_1 (customer_sid
OPTIONS(description='unique identifier of the customer (surrogate key)'), score_type_sid
OPTIONS(description='Surrogate Key SCORE TYPE'), model_sid OPTIONS(description='Surrogate Key MODEL'), geo_area_sid
OPTIONS(description='unique identifier of the geographical area (surrogate key)'), run_tmsp
OPTIONS(description='relevant timestamp of the model run'), active_from_dt
OPTIONS(description='begin of the timeframe the model run result is valid for. This is in general the first day of a reference period, e.g. the Monday of the reference week for a weekly model.'),
score_measure
OPTIONS(description='result of the calculation of a score type for an individual customer in a certain model run.'),
model_area_cd OPTIONS(description='sprechender Code, CX, LDL+,AP'), model_group_cd
OPTIONS(description='eindeutiger code, der mit dem area_cd beginnt z.b. AP_bakeoff or CX_store_rating'), dwh_load_id
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'), dwh_created
OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'), dwh_updated
OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'))
OPTIONS(DESCRIPTION = `$Revision: 0000 $. THIS TABLE CONTAINS THE CALCULATED SCORES FOR CUSTOMERS WHICH HAVE BEEN CALCULATED IN MODEL RUNS OF MODELS FOR CUSTOMER SEGMENTATION`)
AS SELECT customer_sid,
 score_type_sid,
 model_sid,
 geo_area_sid,
 run_tmsp,
 active_from_dt,
 score_measure,
 model_area_cd,
 model_group_cd,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_customer_score_1;
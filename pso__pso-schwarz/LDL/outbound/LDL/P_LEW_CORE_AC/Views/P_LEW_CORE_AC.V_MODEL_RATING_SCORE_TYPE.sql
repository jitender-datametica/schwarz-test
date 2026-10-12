CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_model_rating_score_type (model_sid OPTIONS(description='Surrogate Key MODEL'),
rating_score_type_sid OPTIONS(description='Surrogate Key RATING SCORE TYPE'), dwh_load_id
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'), dwh_created
OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'), dwh_updated
OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'))
OPTIONS(DESCRIPTION = `THIS TABLE CONTAINS THE INFORMATION WHICH RATING SCORE WILL BE CALCULATED AND USED IN WHICH MODEL`)
AS SELECT model_sid,
 rating_score_type_sid,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_model_rating_score_type;
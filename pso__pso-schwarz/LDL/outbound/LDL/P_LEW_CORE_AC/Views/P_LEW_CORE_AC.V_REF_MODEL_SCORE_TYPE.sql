CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_model_score_type (model_sid OPTIONS(description='Surrogate Key MODEL'),
score_type_sid OPTIONS(description='Surrogate Key SCORE TYPE'), model_area_cd
OPTIONS(description='Sprechender Code, CX, LDL+, AP.'), model_group_cd
OPTIONS(description='Eindeutiger Code, der mit dem area_cd beginnt z.b. AP_bakeoff oder CX_store_rating.'), dwh_load_id
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'), dwh_created
OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'), dwh_updated
OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'))
OPTIONS(DESCRIPTION = `$Revision: 0000 $. THIS TABLE CONTAINS THE INFORMATION WHICH SCORE WILL BE CALCULATED AND USED IN WHICH MODEL`)
AS SELECT model_sid,
 score_type_sid,
 model_area_cd,
 model_group_cd,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_model_score_type;
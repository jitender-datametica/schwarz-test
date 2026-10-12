CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_score_type (score_type_sid
OPTIONS(description='Surrogate Key SCORE TYPE'), score_type_name OPTIONS(description='name of the score type'),
score_type_descr OPTIONS(description='description of the score type'), dwh_load_id
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'), dwh_created
OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'), dwh_updated
OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH')) AS SELECT score_type_sid,
 score_type_name,
 score_type_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_score_type;
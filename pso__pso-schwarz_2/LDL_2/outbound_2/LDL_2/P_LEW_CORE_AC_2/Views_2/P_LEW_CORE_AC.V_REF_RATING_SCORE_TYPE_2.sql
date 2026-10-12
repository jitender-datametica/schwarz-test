CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_rating_score_type_2 (rating_score_type_sid
OPTIONS(description='Surrogate Key RATING SCORE TYPE'), rating_score_type_name
OPTIONS(description='Name of the rating score type'), rating_score_type_descr
OPTIONS(description='Description of the rating score type'), dwh_load_id
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingefügt oder verändert hat.'), dwh_created
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'), dwh_updated
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'))
OPTIONS(DESCRIPTION = `THIS TABLE CONTAINS RATING SCORE TYPES. A RATING SCORE TYPE IS A CERTAIN WELL DEFINED CALCULATION WHICH WILL BE CALCULATED IF A RATING MODEL IS APPLIED. THE RESULT WILL BE STORED AS AN INTERMEDIATE OR FINAL RESULT TO ALLOW THE ASSIGNEMENT OF ENTITIES TO RATING CLASSES.`)
AS SELECT rating_score_type_sid,
 rating_score_type_name,
 rating_score_type_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_rating_score_type_2;
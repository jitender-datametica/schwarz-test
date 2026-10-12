CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_item_rating_element_score_1 (item_rating_element_sid
OPTIONS(description='Surrogate Key ITEM_1 RATING ELEMENT.'), rating_score_type_sid
OPTIONS(description='Surrogate Key RATING SCORE TYPE.'), rating_score_meas
OPTIONS(description='Value of the calculated rating score.'), dwh_load_id
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingefügt oder verändert hat.'), dwh_created
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'), dwh_updated
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'))
OPTIONS(DESCRIPTION = `THIS TABLE CONTAINS THE RATING SCORES CALCULATED FOR RATING ELEMENTS FOR A CERTAIN ITEM_1 RATING USING A MODEL.`)
AS SELECT item_rating_element_sid,
 rating_score_type_sid,
 rating_score_meas,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_item_rating_element_score_1;
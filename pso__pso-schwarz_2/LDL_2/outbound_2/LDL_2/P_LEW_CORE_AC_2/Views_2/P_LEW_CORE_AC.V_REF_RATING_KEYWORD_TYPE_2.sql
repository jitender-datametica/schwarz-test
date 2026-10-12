CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_rating_keyword_type_2 (rating_keyword_type_cd
OPTIONS(description='Code for the discriminator values for keyword types used in rating.'), rating_keyword_type_descr
OPTIONS(description='A textual description for the discriminator value for keyword types used in rating.'), dwh_load_id
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'), dwh_created
OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'), dwh_updated
OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'))
OPTIONS(DESCRIPTION = `THE MINOR DIMENSION THAT CONTAIN KEYWORD TYPES USED IN RATING ( FOR EXAMPLE NOUN , ADJECTIVE , VERB , ETC)`)
AS SELECT rating_keyword_type_cd,
 rating_keyword_type_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_rating_keyword_type_2;
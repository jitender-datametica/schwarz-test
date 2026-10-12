CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_despatch_advice_check_type_2 (despatch_advice_check_type_id
OPTIONS(description='Identification of the despatch advice difference check type.'), despatch_advice_check_type_descr
OPTIONS(description='Description of the despatch advice difference check type.'), dwh_load_id
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'), dwh_created
OPTIONS(description='The timestamp when the row was inserted.'), dwh_updated
OPTIONS(description='The timestamp when the row was updated the last time.'))
OPTIONS(DESCRIPTION = `LIST OF ALL DESPATCH ADVICE DIFFERENCE CHECK TYPES, LIKE MISSING ARTICLE, DIFFERENCE IN QTY, ETC.`)
AS SELECT despatch_advice_check_type_id,
 despatch_advice_check_type_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_despatch_advice_check_type_2;
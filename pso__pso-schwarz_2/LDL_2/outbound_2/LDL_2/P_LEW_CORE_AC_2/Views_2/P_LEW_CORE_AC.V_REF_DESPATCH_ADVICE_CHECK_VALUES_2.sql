CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_despatch_advice_check_values_2 (despatch_advice_check_type_value_id
OPTIONS(description='Code value for differences check outcome.'), despatch_advice_check_type_value_descr
OPTIONS(description='Description for the code value of the difference check outcome.'), dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = `LIST OF ALL POSSIBLE STATUS_2 VALUES FOR DESPATCH ADVICE DIFFERENCES CLASSIFYING THE CHECK OUTCOME.`)
AS SELECT despatch_advice_check_type_value_id,
 despatch_advice_check_type_value_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_despatch_advice_check_values_2;
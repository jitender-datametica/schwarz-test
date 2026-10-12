CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_despatch_advice_difference_status_1 (despatch_advice_diff_status_id
OPTIONS(description='Status_1 ID of the despatch advice differences check, such as open, resolved, deleted.'),
despatch_advice_diff_status_descr OPTIONS(description='description of status_1 of despatch advice differences check'),
dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = `STATIC STATUS_1 VALUES FOR DESPATCH ADVICE DIFFERENCE CHECK LIKE OPEN, RESOLVED, DELETED.`) AS
SELECT despatch_advice_diff_status_id,
 despatch_advice_diff_status_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_despatch_advice_difference_status_1;
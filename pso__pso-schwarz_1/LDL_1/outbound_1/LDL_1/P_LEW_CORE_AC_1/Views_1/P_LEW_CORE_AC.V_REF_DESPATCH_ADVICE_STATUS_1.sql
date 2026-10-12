CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_despatch_advice_status_1 (despatch_advice_status_id
OPTIONS(description='Status_1 ID of the despatch advice such as open, booked, invalid, differences, deleted.'),
despatch_advice_status_descr OPTIONS(description='Description of status_1 for despatch advice.'), dwh_load_id
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'), dwh_created
OPTIONS(description='The timestamp when the row was inserted.'), dwh_updated
OPTIONS(description='The timestamp when the row was updated the last time.'))
OPTIONS(DESCRIPTION = `STATIC STATUS_1 VALUES FOR DESPATCH ADVICE LIKE OPEN, BOOKED, INVALID, DIFFERENCES, DELETED.`) AS
SELECT despatch_advice_status_id,
 despatch_advice_status_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_despatch_advice_status_1;
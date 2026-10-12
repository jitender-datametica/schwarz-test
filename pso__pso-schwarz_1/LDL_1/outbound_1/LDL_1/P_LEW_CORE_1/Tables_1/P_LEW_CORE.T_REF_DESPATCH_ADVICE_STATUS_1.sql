/* --------------------------------------------------------------------------------
   DDL for table: t_ref_despatch_advice_status_1
   generated from Powerdesigner on Tuesday, February 4, 2025 12:24:54 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_despatch_advice_status_1 (
despatch_advice_status_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Status_1 ID of the despatch advice such as open, booked, invalid, differences, deleted.'),
despatch_advice_status_descr STRING(250) OPTIONS(description='Description of status_1 for despatch advice.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'),
dwh_created DATETIME NOT NULL OPTIONS(description='The timestamp when the row was inserted.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='The timestamp when the row was updated the last time.'),
PRIMARY KEY (despatch_advice_status_id) NOT ENFORCED
) OPTIONS(description='Static status_1 values for despatch advice like open, booked, invalid, differences, deleted.');
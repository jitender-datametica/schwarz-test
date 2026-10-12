/* --------------------------------------------------------------------------------
   DDL for table: t_ref_despatch_advice_check_type_2
   generated from Powerdesigner on Tuesday, February 4, 2025 12:13:25 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_despatch_advice_check_type_2 (
despatch_advice_check_type_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identification of the despatch advice difference check type.'),
despatch_advice_check_type_descr STRING(250)
OPTIONS(description='Description of the despatch advice difference check type.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'),
dwh_created DATETIME NOT NULL OPTIONS(description='The timestamp when the row was inserted.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='The timestamp when the row was updated the last time.'),
PRIMARY KEY (despatch_advice_check_type_id) NOT ENFORCED
)
OPTIONS(description='List of all despatch advice difference check types, like missing article, difference in qty, etc.');
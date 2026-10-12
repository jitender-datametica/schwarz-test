/* --------------------------------------------------------------------------------
   DDL for table: t_ref_despatch_advice_check_values
   generated from Powerdesigner on Tuesday, February 4, 2025 12:17:56 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_despatch_advice_check_values (
despatch_advice_check_type_value_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Code value for differences check outcome.'),
despatch_advice_check_type_value_descr STRING(250)
OPTIONS(description='Description for the code value of the difference check outcome.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (despatch_advice_check_type_value_id) NOT ENFORCED
)
OPTIONS(description='List of all possible status values for despatch advice differences classifying the check outcome.');
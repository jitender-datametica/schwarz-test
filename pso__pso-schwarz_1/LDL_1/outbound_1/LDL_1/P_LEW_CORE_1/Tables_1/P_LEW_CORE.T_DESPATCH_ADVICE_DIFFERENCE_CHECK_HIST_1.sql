/* --------------------------------------------------------------------------------
   DDL for table: t_despatch_advice_difference_check_hist_1
   generated from Powerdesigner on Tuesday, February 4, 2025 12:04:46 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_despatch_advice_difference_check_hist_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
wh_loc_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key warehouse, foreign key on location.'),
despatch_advice_diff_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key based on difference per despatch advice (and warehouse).            C0025_despatch_adviceid and C0025_id'),
despatch_advice_check_type_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Code of the despatch advice difference check type.'),
despatch_advice_check_type_fg BIGNUMERIC(38,0) OPTIONS(description='Flag: Set if difference exists.'),
despatch_advice_check_type_value_id BIGNUMERIC(38,0)
OPTIONS(description='Code of the check type value for differences checked'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Attribute set was not delivered by source system (anymore), if deleted_fg=1.'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Begin of the validity_1 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='End of the validity_1 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (despatch_advice_diff_sid, despatch_advice_check_type_id, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='Table with all the checks and its changes during the checks. Each difference can have multiple checks.             Source: WAWI table: T0025_DESPATCH_ADVICE_DIFFERENCE');
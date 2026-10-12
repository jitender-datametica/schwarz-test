/* --------------------------------------------------------------------------------
   DDL for table: t_ref_despatch_advice_difference_status
   generated from Powerdesigner on Tuesday, February 4, 2025 12:21:55 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_despatch_advice_difference_status (
despatch_advice_diff_status_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Status ID of the despatch advice differences check, such as open, resolved, deleted.'),
despatch_advice_diff_status_descr STRING(250)
OPTIONS(description='description of status of despatch advice differences check'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (despatch_advice_diff_status_id) NOT ENFORCED
) OPTIONS(description='Static status values for despatch advice difference check like open, resolved, deleted.');
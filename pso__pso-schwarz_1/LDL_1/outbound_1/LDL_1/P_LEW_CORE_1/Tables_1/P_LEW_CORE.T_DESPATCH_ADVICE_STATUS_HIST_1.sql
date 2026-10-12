/* --------------------------------------------------------------------------------
   DDL for table: t_despatch_advice_status_hist_1
   generated from Powerdesigner on Tuesday, February 4, 2025 12:12:22 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_despatch_advice_status_hist_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
wh_loc_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key warehouse, foreign key on location.'),
despatch_advice_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the individual despatch advice at a warehouse.            Row number of the WAWI source table T0020_DESPATCH_ADVICE_1 in the local WAWI system.'),
despatch_advice_status_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Status_1 ID of the despatch advice such as open, booked, invalid, differences, deleted.'),
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
PRIMARY KEY (wh_loc_sid, despatch_advice_id, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='The table stores changes to despatch advices from supplieres in warehouse.             Source: WAWI table: T0020_DESPATCH_ADVICE_1');
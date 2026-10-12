/* --------------------------------------------------------------------------------
   DDL for table: t_despatch_advice_difference_hist_1
   generated from Powerdesigner on Tuesday, February 4, 2025 12:09:33 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_despatch_advice_difference_hist_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
wh_loc_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key warehouse, foreign key on location.'),
despatch_advice_diff_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key based on difference per despatch advice (and warehouse).            C0025_despatch_adviceid and C0025_id'),
ordered_gtin STRING(14) OPTIONS(description='Global Trade Item_1 Number (GTIN) of the article ordered from the supplier.'),
received_gtin STRING(14)
OPTIONS(description='Global Trade Item_1 Number (GTIN) of the article received from the supplier.'),
ordered_item_sid BIGNUMERIC(38,0) OPTIONS(description='Surrogate key of the article ordered from the supplier.'),
received_item_sid BIGNUMERIC(38,0) OPTIONS(description='Surrogate key of the article received from the supplier.'),
order_record_id STRING(100)
OPTIONS(description='Order number: src_orig_supplier_nr (4 digits), date (DDMMYY, 6 digits) and counting version number (2 digits) for supllier - Date combination; Wawi: PO_NR.'),
despatch_advice_diff_status_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Status_1 of the despatch advice differences.'),
diff_accepted_fg BIGNUMERIC(38,0) OPTIONS(description='Flag: Set if difference is accepted.'),
remark_fg BIGNUMERIC(38,0) OPTIONS(description='Flag: Set if remark exists.'),
remark_txt STRING(1000) OPTIONS(description='Remark entered for the despatch advice difference.'),
partial_delivery_fg BIGNUMERIC(38,0) OPTIONS(description='Flag: Set if partial delivery was accepted.'),
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
PRIMARY KEY (despatch_advice_diff_sid, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='This table contains historized changes to differences found in despatch advices at the warehouse.             Source: WAWI table: T0025_DESPATCH_ADVICE_DIFFERENCES');
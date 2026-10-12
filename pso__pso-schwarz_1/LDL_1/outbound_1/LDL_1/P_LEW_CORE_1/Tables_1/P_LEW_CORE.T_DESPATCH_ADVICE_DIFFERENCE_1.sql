/* --------------------------------------------------------------------------------
   DDL for table: t_despatch_advice_difference_1
   generated from Powerdesigner on Monday, March 31, 2025 10:16:44 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_despatch_advice_difference_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
wh_loc_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key warehouse, foreign key on location.'),
despatch_advice_diff_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key based on difference per despatch advice (and warehouse). Usually one line for all differences per item.            C0025_despatch_adviceid and C0025_id'),
despatch_advice_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Reference to a despatch advice, if a despatch advice technically has been used in the counting process.'),
despatch_advice_diff_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Number of the individual item_1 difference entered for a despatch advice delivered. It is the row number of the difference in the source system, the natural key.'),
src_orig_wh_nr BIGNUMERIC(38,0) OPTIONS(description='Techn. identifier of warehouses in WAWI source system.'),
diff_create_dt DATE NOT NULL OPTIONS(description='Date on which the despatch advice difference item_1 was entered.'),
diff_create_tmsp DATETIME NOT NULL
OPTIONS(description='Point in time at which the despatch advice difference item_1 was entered.'),
diff_change_dt DATE OPTIONS(description='Date on which the despatch advice difference item_1 was modified.'),
diff_change_tmsp DATETIME
OPTIONS(description='Point in time at which the despatch advice difference item_1 was modified.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (despatch_advice_diff_sid) NOT ENFORCED
)
OPTIONS(description='Differences between despatch advices and purchase orders, checked at the warehouse.             Source: WAWI table: T0025_DESPATCH_ADVICE_DIFFERENCES');
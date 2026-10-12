CREATE OR REPLACE TABLE ldl_p_lew_core.t_non_personalized_discount_hist (
client_id INTEGER NOT NULL OPTIONS(description='unique identifier of the DWH client / slice'),
np_discount_sid INTEGER NOT NULL OPTIONS(description='Foreign Key for t_non_personalized_discount'),
np_discount_status_cd STRING(100) NOT NULL OPTIONS(description='Status of the non personalized discount.'),
np_discount_start_dt DATE NOT NULL OPTIONS(description='Start date of the non personalized discount.'),
np_discount_end_dt DATE NOT NULL OPTIONS(description='End date of the non personalized discount.'),
np_discount_booking_type_id INTEGER NOT NULL
OPTIONS(description='Price change reason (analogous to ERP price change reasons) to be used for the discount.'),
np_discount_descr STRING(250) NOT NULL OPTIONS(description='Description of the non personalized discount.'),
receipt_np_discount_name STRING(100) NOT NULL
OPTIONS(description='Name to be displayed in the discount line on the receipt.'),
prev_np_discount_sid INTEGER OPTIONS(description='Surrogate Key of the predecessor of a non personalized discount.'),
deleted_fg INTEGER NOT NULL
OPTIONS(description='relation was not delivered by source system (anymore), if deleted_fg=1'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Begin of the validity interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='End of the validity interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp_ntz(9) of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp_ntz(9) of the last update of the record in the DWH.'),
PRIMARY KEY (np_discount_sid, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='This table contains the non personalised discount (historised version).');
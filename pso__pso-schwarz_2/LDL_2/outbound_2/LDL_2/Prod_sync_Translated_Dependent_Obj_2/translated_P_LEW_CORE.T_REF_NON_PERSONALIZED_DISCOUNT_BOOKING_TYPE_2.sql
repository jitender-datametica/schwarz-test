CREATE OR REPLACE TABLE ldl_p_lew_core.t_ref_non_personalized_discount_booking_type_2 (
np_discount_booking_type_id INTEGER NOT NULL
OPTIONS(description='Code for the price change reason of  the non personalized discount.'),
np_discount_booking_type_name STRING(100) NOT NULL
OPTIONS(description='Name for the price change reason of the non personalized discount.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp_ntz(9) of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp_ntz(9) of the last update of the record in the DWH.'),
PRIMARY KEY (np_discount_booking_type_id) NOT ENFORCED
) OPTIONS(description='This table contains the different booking type of a non personalized discount.');
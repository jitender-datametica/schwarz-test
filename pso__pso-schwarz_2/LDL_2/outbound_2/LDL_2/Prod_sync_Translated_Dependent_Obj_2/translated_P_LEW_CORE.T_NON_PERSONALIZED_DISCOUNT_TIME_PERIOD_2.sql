CREATE OR REPLACE TABLE ldl_p_lew_core.t_non_personalized_discount_time_period_2 (
client_id INTEGER NOT NULL OPTIONS(description='unique identifier of the DWH client / slice.'),
np_discount_sid INTEGER NOT NULL OPTIONS(description='Surrogate Key of the non personalized discount.'),
np_discount_action_nr INTEGER NOT NULL
OPTIONS(description='Unique Identifier of the action for a non-personalized discount.'),
day_of_week INTEGER NOT NULL
OPTIONS(description='The day of the week on which the non- personalized discount is active within its validity_2 period.'),
np_discount_start_dt DATE NOT NULL OPTIONS(description='Start date of the non-personalized discount.'),
np_discount_end_dt DATE NOT NULL OPTIONS(description='End date of the non-personalized discount.'),
np_discount_start_time TIME NOT NULL
OPTIONS(description='The start time at which the the non-personalized discount  becomes active within its validity_2 period.'),
np_discount_end_time TIME NOT NULL
OPTIONS(description='The end time until which the non-personalized discount  remains active within its validity_2 period.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp_ntz(9) of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp_ntz(9) of the last update of the record in the DWH.'),
PRIMARY KEY (np_discount_sid, np_discount_action_nr, day_of_week) NOT ENFORCED
) OPTIONS(description='This table defines the validity_2 intervals for non-personalized discount.');
CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_non_personalized_discount_time_period_1 (client_id
OPTIONS(description='unique identifier of the DWH client / slice.'), np_discount_sid
OPTIONS(description='Surrogate Key of the non personalized discount.'), np_discount_action_nr
OPTIONS(description='Unique Identifier of the action for a non-personalized discount.'), day_of_week
OPTIONS(description='The day of the week on which the non- personalized discount is active within its validity_1 period.'),
np_discount_start_dt OPTIONS(description='Start date of the non-personalized discount.'), np_discount_end_dt
OPTIONS(description='End date of the non-personalized discount.'), np_discount_start_time
OPTIONS(description='The start time at which the the non-personalized discount  becomes active within its validity_1 period.'),
np_discount_end_time
OPTIONS(description='The end time until which the non-personalized discount  remains active within its validity_1 period.'),
dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp_ntz(9) of the record in the DWH.'), dwh_updated
OPTIONS(description='timestamp_ntz(9) of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = `This table defines the validity_1 intervals for non-personalized discount.`) AS SELECT client_id,
 np_discount_sid,
 np_discount_action_nr,
 day_of_week,
 np_discount_start_dt,
 np_discount_end_dt,
 np_discount_start_time,
 np_discount_end_time,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_non_personalized_discount_time_period_1;
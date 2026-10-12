CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_location_opening_hour_hist (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Unique identifier of the DWH client / slice.'),
store_loc_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key LOCATION (eindeutig ueber alle Laender / Mandanten hinweg).'),
cal_dt DATE NOT NULL OPTIONS(description='WAWI: x_data.t_cal_calendarday.dat_calendar'),
opening_tm TIME OPTIONS(description='The time when the stores opens. E.g. 08:00; Time is in local time.'),
closing_tm TIME
OPTIONS(description='The time when the stores closes. E.g. 20:00; Time is in local time. In case the store is closed during lunch time, this is the final closing time in the evening.'),
break_start_tm TIME
OPTIONS(description='In case the store is closed for lunch break / siesta - this is the begin time of the break.'),
break_end_tm TIME
OPTIONS(description='In case the store is closed for lunch break / siesta - this is the end time of the break.'),
store_open_fg BIGNUMERIC(38,0) OPTIONS(description='Indicator that store was open on this date'),
store_operating_type_cd STRING(100)
OPTIONS(description='A code for an operating types for a store  ( regular opening , public holiday , permanent closure)'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'),
dwh_created DATETIME NOT NULL OPTIONS(description='The timestamp when the row was inserted.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='The timestamp when the row was updated the last time.'),
PRIMARY KEY (store_loc_sid, cal_dt) NOT ENFORCED
) OPTIONS(description='Contains history of opening hours for the shop');
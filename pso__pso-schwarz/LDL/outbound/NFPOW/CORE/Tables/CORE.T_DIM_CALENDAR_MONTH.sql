CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_calendar_month (
cal_month BIGNUMERIC(38,0) NOT NULL,
ldl_cal_month_name STRING(100),
cal_year BIGNUMERIC(38,0) NOT NULL,
month_of_cal_year BIGNUMERIC(38,0)
OPTIONS(description='The month of the calendar year as a number using the convention January = 1 ... December = 12.'),
prev_1y_cal_month BIGNUMERIC(38,0),
cal_month_offset BIGNUMERIC(38,0)
OPTIONS(description='The difference in months between this calendar month and the current month. So if current calendar month is 201901, then the offset is 0 for 201901, -1 for 201812 and +1 for 201902.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (cal_month) NOT ENFORCED
) OPTIONS(description='');
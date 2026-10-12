CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_cal_quarter_2 (
cy_qtr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The ID of the calendar_2 year quarter in form of YYYYQ'),
cy BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Calendar_2 Year'),
qtr_of_cy BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Number of the quarter within the calendar_2 year (1-4)'),
cy_qtr_name STRING(100) NOT NULL OPTIONS(description='The name of the calendar_2 year quarter.'),
cy_qtr_begin_month BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The month ID of the begin of the calendar_2 year quarter.'),
cy_qtr_end_month BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The month ID of the end of the calendar_2 year quarter.'),
cy_qtr_seq BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The offset of the calendar_2 year quarter from the point of view of the last loaded day.'),
cy_qtr_prev_1q BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The ID of the calendar_2 year quarter of the previous quarter.'),
cy_qtr_prev_1y BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The ID of the calendar_2 year quarter of the previous year.'),
cy_qtr_prev_2y BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The ID of the calendar_2 year quarter two years ago.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run that inserted or updated this row.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Timestamp of the insertion of this row.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of this row.'),
PRIMARY KEY (cy_qtr) NOT ENFORCED
) OPTIONS(description='Calendar_2 Quarter Table');
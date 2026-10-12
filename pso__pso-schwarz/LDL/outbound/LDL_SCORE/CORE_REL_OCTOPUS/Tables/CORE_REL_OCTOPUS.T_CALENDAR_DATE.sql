CREATE TABLE IF NOT EXISTS ldl_score_core_rel_octopus.t_calendar_date (
cal_dt DATE NOT NULL
OPTIONS(description='Assigned date, in this case the last date where the good has to be delivered at the receiving warehouse'),
day_of_week BIGNUMERIC OPTIONS(description='Day within the year 1-7'),
weekend_fg BOOL OPTIONS(description='The flag indicates whether is is a Saturday or Sunday. '),
day_of_cy BIGNUMERIC OPTIONS(description='Day within the year 1-365'),
cy_month BIGNUMERIC OPTIONS(description='Month identifier 1-12 in composition with the year'),
month_of_year BIGNUMERIC NOT NULL OPTIONS(description='Month 1-12 (January = 1, ..., December = 12)'),
cy_week BIGNUMERIC OPTIONS(description='A composition of (calendar year + week) e.g. 201.132 = year 2011 week 32'),
cy BIGNUMERIC NOT NULL OPTIONS(description='Calendar year'),
bus_year BIGNUMERIC NOT NULL
OPTIONS(description='The business year at Lidl from March to February and thus begins on 01.03'),
cal_dt_prev_7d DATE
OPTIONS(description='Assigned date, in this case the last date where the good has to be delivered at the receiving warehouse - 7 days'),
cal_dt_swday_prev_1y DATE
OPTIONS(description='Assigned date, in this case the last date where the good has to be delivered at the receiving warehouse - 1 year'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (cal_dt) NOT ENFORCED
) OPTIONS(description='Is the calendar table which separates the according months, days, years and weeks. ');
CREATE OR REPLACE TABLE public.calendar_1 (
calendar_date DATE NOT NULL,
day_of_week BIGNUMERIC(38,0) NOT NULL,
day_of_month BIGNUMERIC(38,0) NOT NULL,
day_of_year BIGNUMERIC(38,0) NOT NULL,
day_of_calendar BIGNUMERIC(38,0) NOT NULL,
weekday_of_month BIGNUMERIC(38,0) NOT NULL,
week_of_month BIGNUMERIC(38,0) NOT NULL,
week_of_year BIGNUMERIC(38,0) NOT NULL,
week_of_calendar BIGNUMERIC(38,0) NOT NULL,
month_of_quarter BIGNUMERIC(38,0) NOT NULL,
month_of_year BIGNUMERIC(38,0) NOT NULL,
month_of_calendar BIGNUMERIC(38,0) NOT NULL,
quarter_of_year BIGNUMERIC(38,0) NOT NULL,
quarter_of_calendar BIGNUMERIC(38,0) NOT NULL,
year_of_calendar BIGNUMERIC(38,0) NOT NULL
);
CREATE TABLE IF NOT EXISTS ldl_score_core_octopus.t_dim_calendar_month (
cy_month BIGNUMERIC NOT NULL OPTIONS(description='Month identifier 1-12 in composition with the year'),
month_of_year BIGNUMERIC NOT NULL OPTIONS(description='Month 1-12 (January = 1, ..., December = 12)'),
cy BIGNUMERIC NOT NULL OPTIONS(description='The year '),
bus_year BIGNUMERIC NOT NULL
OPTIONS(description='The business year at Lidl from March to February and thus begins on 01.03'),
cy_month_seq BIGNUMERIC
OPTIONS(description='The current month has the sequence number 0. The next month takes the value 1. Beginning with a negative number from January 2012. '),
cy_month_descr STRING(100) OPTIONS(description='The month and the year (written out)'),
cy_month_short_descr STRING(100) OPTIONS(description='The month and the year (abbreviated)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (cy_month) NOT ENFORCED
) OPTIONS(description='Contains the year in combination with the corresponding month. ');
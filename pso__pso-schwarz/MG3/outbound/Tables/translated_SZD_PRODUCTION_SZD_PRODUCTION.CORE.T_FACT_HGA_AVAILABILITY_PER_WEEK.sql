CREATE OR REPLACE TABLE szd_production_core.t_fact_hga_availability_per_week (
hga_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the hot beverage machine which is loacted in a store'),
cy_week INTEGER NOT NULL
OPTIONS(description='The number to which this week belongs, in the form YYYYWW. YYYY is the year of the week and WW is the number of the week within the calendar year. Week 1 is the first week in the calendar year containing at least 4 days.'),
weekly_avail_pct NUMERIC(29,5) NOT NULL
OPTIONS(description='The time duration in seconds during which the machine is functioning'),
no_sale_weekly_val NUMERIC(29,5) NOT NULL
OPTIONS(description='The computed weekly value where there was no sale for more than 6 hours between consecutive sales'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (hga_sid, cy_week) NOT ENFORCED
)
OPTIONS(description='Transactional fact capturing the uptime in seconds per week of hot beverage machines located in stores');
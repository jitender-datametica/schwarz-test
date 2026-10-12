CREATE OR REPLACE TABLE szd_production_core.t_fact_hga_availability_per_day (
hga_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the hot beverage machine which is loacted in a store'),
avail_dt DATE NOT NULL OPTIONS(description='The calendar date of the machine availability'),
daily_avail_pct NUMERIC(29,5) NOT NULL
OPTIONS(description='The time duration in seconds during which the machine is functioning'),
no_sale_daily_val NUMERIC(29,5) NOT NULL
OPTIONS(description='The computed daily value where there was no sale for more than 6 hours between consecutive sales'),
last_online_tmsp TIMESTAMP NOT NULL OPTIONS(description='The report timestamp of the source file'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (hga_sid, avail_dt) NOT ENFORCED
)
OPTIONS(description='Transactional fact capturing the uptime in seconds per day of hot beverage machines located in stores');
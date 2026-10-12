CREATE OR REPLACE TABLE szd_production_core.t_fact_hga_total_availability (
hga_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the hot beverage machine which is loacted in a store'),
start_dt DATE NOT NULL OPTIONS(description='The start date of the source file'),
end_dt DATE NOT NULL OPTIONS(description='The latest date of the source file'),
total_avail_pct NUMERIC(29,5) NOT NULL
OPTIONS(description='The total availability measure of machine between the start date and end date of source file'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
last_online_tmsp TIMESTAMP
OPTIONS(description='The latest timestamp of the report source file for respective machine'),
PRIMARY KEY (hga_sid) NOT ENFORCED
) OPTIONS(description='Aggregate fact capturing the total availability of machine for a given start and end date');
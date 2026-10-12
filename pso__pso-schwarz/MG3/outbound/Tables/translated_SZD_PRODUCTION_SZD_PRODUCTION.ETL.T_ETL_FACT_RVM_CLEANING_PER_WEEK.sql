CREATE OR REPLACE TABLE szd_production_etl.t_etl_fact_rvm_cleaning_per_week (
rvm_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the despotie machine which is located in a store'),
cy_week INTEGER NOT NULL
OPTIONS(description='The week as a number of the form YYYYWW. YYYY is the year of the week and WW is the number of the week within the calendar year. Week 1 is the first week in the calendar year containing at least 4 days.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
cleaning_completed_weekly_pct NUMERIC(29,5) NOT NULL
OPTIONS(description='The percentage for the completed cleanings per week'),
PRIMARY KEY (rvm_sid, cy_week) NOT ENFORCED
);
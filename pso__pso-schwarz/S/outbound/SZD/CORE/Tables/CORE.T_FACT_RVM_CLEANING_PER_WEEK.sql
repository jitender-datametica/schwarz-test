CREATE TABLE IF NOT EXISTS szd_core.t_fact_rvm_cleaning_per_week (
rvm_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the despotie machine which is located in a store'),
cy_week BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The week as a number of the form YYYYWW. YYYY is the year of the week and WW is the number of the week within the calendar year. Week 1 is the first week in the calendar year containing at least 4 days.'),
cleaning_completed_weekly_pct BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The percentage for the completed cleanings per week'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (rvm_sid, cy_week) NOT ENFORCED
) OPTIONS(description='Transactional facts capturing the cleaning operations of deposit machines.');
CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_market_research_business_calendar_2 (
period_name STRING(100) NOT NULL,
periode_jahr STRING(100) NOT NULL,
period_type_cd STRING(100) NOT NULL,
prev_year_period_name STRING(100) NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated DATETIME NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (period_type_cd, period_name) NOT ENFORCED
) OPTIONS(description='Load table for XSIGHT Business Calendar_2');
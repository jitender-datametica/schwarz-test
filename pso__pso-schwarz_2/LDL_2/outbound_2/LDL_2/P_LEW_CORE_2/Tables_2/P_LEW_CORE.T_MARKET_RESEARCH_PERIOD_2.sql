/* --------------------------------------------------------------------------------
   DDL for table: t_market_research_period_2
   generated from Powerdesigner on Dienstag, 6. Mai 2025 11:46:00
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_market_research_period_2 (
market_research_period_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for a time period that is defined by a provider of market research data.'),
market_research_data_provider_name STRING(100) NOT NULL
OPTIONS(description='The name by which the market data provider is known.'),
market_research_data_src_name STRING(100) NOT NULL
OPTIONS(description='The name by which the market data source is known.'),
market_research_calendar_name STRING(100) NOT NULL
OPTIONS(description='The name by which the custom calendar_2 is known.'),
market_research_period_name STRING(100) NOT NULL OPTIONS(description='The display name of the time period.'),
market_research_period_type_cd STRING(100) NOT NULL OPTIONS(description='The code identifying the kind of time period.'),
cy BIGNUMERIC(38,0)
OPTIONS(description='The calendar_2 year to which this period is assigned. (Note that periods might span two years, but they are always linked to a year.)'),
market_research_period_start_dt DATE OPTIONS(description='The calendar_2 date when the period started.'),
market_research_period_end_dt DATE OPTIONS(description='The calendar_2 date when the period ended.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'),
PRIMARY KEY (market_research_period_sid) NOT ENFORCED
)
OPTIONS(description='A time period, as defined by providers of market research data. A time period is defined by its start date and its end date and by its type. It may or may not be identical to the standard periods, such as calendar_2 weeks, months, quarters or years.');
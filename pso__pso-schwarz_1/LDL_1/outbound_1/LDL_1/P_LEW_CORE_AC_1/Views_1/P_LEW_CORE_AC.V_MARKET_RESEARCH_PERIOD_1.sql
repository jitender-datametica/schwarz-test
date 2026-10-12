CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_market_research_period_1 (market_research_period_sid
OPTIONS(description='The unique identifier (surrogate key) for a time period that is defined by a provider of market research data.'),
market_research_data_provider_name OPTIONS(description='The name by which the market data provider is known.'),
market_research_data_src_name OPTIONS(description='The name by which the market data source is known.'),
market_research_calendar_name OPTIONS(description='The name by which the custom calendar_1 is known.'),
market_research_period_name OPTIONS(description='The display name of the time period.'), market_research_period_type_cd
OPTIONS(description='The code identifying the kind of time period.'), cy
OPTIONS(description='The calendar_1 year to which this period is assigned. (Note that periods might span two years, but they are always linked to a year.)'),
market_research_period_start_dt OPTIONS(description='The calendar_1 date when the period started.'),
market_research_period_end_dt OPTIONS(description='The calendar_1 date when the period ended.'), dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'))
OPTIONS(DESCRIPTION = `A TIME PERIOD, AS DEFINED BY PROVIDERS OF MARKET RESEARCH DATA. A TIME PERIOD IS DEFINED BY ITS START DATE AND ITS END DATE AND BY ITS TYPE. IT MAY OR MAY NOT BE IDENTICAL TO THE STANDARD PERIODS, SUCH AS CALENDAR_1 WEEKS, MONTHS, QUARTERS OR YEARS.`)
AS SELECT market_research_period_sid,
 market_research_data_provider_name,
 market_research_data_src_name,
 market_research_calendar_name,
 market_research_period_name,
 market_research_period_type_cd,
 cy,
 market_research_period_start_dt,
 market_research_period_end_dt,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_market_research_period_1;
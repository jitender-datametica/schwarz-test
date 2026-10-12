CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_local_market_research_period (market_research_data_provider_name
OPTIONS(description='The name by which the market data provider is known.'), market_research_data_src_name
OPTIONS(description='The name by which the market data source is known.'), market_research_country_cd
OPTIONS(description='The code which identifies a country (as defined by a provider of market research data)'),
market_research_data_src_segment_name
OPTIONS(description='The name by which the segment of a market data report is known.'), src_period_nr
OPTIONS(description='The number by which the time period is identified by the data provider.'),
market_research_period_sid
OPTIONS(description='The unique identifier (surrogate key) for a time period that is defined by a provider of market research data.'),
market_research_period_local_name
OPTIONS(description='The name of the time period, as defined in the local market data source segment.'), dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'))
OPTIONS(DESCRIPTION = `TIME PERIODS WHICH ARE DEFINED BY PROVIDERS OF MARKET RESEARCH DATA, MAY BE IDENTIFIED BY MULTIPLE NUMBERS, DEPENDING ON THE COUNTRY AND THE DATA SOURCE. THIS TABLE ASSOCIATES THESE NUMBERS TO THE (GLOBAL) TIME PERID.`)
AS SELECT market_research_data_provider_name,
 market_research_data_src_name,
 market_research_country_cd,
 market_research_data_src_segment_name,
 src_period_nr,
 market_research_period_sid,
 market_research_period_local_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_local_market_research_period;
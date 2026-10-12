CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_market_research_benchmark_channel_1 (market_research_data_provider_name
OPTIONS(description='The name by which the market data provider is known.'), market_research_data_src_name
OPTIONS(description='The name by which the market data source is known.'), market_research_country_cd
OPTIONS(description='The code which identifies a country_1 (as defined by a provider of market research data)'),
market_research_data_src_segment_name
OPTIONS(description='The name by which the segment of a market data report is known.'), market_research_channel_sid
OPTIONS(description='The unique identifier (surrogate key) for a sales_1 channel that is defined by a provider of market research data.'),
default_benchmark_channel_fg
OPTIONS(description='An indicator, showing if this channel is the default benchmark channel for the given segment.'),
dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'))
OPTIONS(DESCRIPTION = `A SEGMENT OF A MARKET RESEARCH DATA SOURCE MAY DEFINE ONE OR SEVERAL BENCHMARK CHANNELS. THESE CHANNELS ARE USED AS REFERENCE TO COMPARE AGAINST. TYPICALLY, THE COUNTRY_1-LEVEL CHANNELS WHICH DOES NOT INCLUDE LIDL ARE USED AS BENCHMARK. ONE OF THESE CHANNELS IS MARKED AS THE DEFAULT CHANNEL.`)
AS SELECT market_research_data_provider_name,
 market_research_data_src_name,
 market_research_country_cd,
 market_research_data_src_segment_name,
 market_research_channel_sid,
 default_benchmark_channel_fg,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_market_research_benchmark_channel_1;
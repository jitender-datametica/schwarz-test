CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_market_research_data_source_segment_1 (market_research_data_provider_name
OPTIONS(description='The name by which the market data provider is known.'), market_research_data_src_name
OPTIONS(description='The name by which the market data source is known.'), market_research_country_cd
OPTIONS(description='The code which identifies a country_1 (as defined by a provider of market research data)'),
market_research_data_src_segment_name
OPTIONS(description='The name by which the segment of a market data report is known.'),
market_research_data_src_segment_display_name
OPTIONS(description='The name of the segment of a market data report, as defined by business.'),
market_research_data_src_segment_descr
OPTIONS(description='A textual description for the segment of a market data report.'), dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'))
OPTIONS(DESCRIPTION = `A MARKET DATA RESEARCH DATA SOURCE MAY CONSIST OF SEVERAL REPORTS, E.G. ONE FOR FOOD, ONE FOR NON-FOOD, ETC.`)
AS SELECT market_research_data_provider_name,
 market_research_data_src_name,
 market_research_country_cd,
 market_research_data_src_segment_name,
 market_research_data_src_segment_display_name,
 market_research_data_src_segment_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_market_research_data_source_segment_1;
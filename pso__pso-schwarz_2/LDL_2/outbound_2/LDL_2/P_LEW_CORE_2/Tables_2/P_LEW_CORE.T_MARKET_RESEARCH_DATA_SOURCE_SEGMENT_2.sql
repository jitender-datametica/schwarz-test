/* --------------------------------------------------------------------------------
   DDL for table: t_market_research_data_source_segment_2
   generated from Powerdesigner on Dienstag, 6. Mai 2025 11:46:00
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_market_research_data_source_segment_2 (
market_research_data_provider_name STRING(100) NOT NULL
OPTIONS(description='The name by which the market data provider is known.'),
market_research_data_src_name STRING(100) NOT NULL
OPTIONS(description='The name by which the market data source is known.'),
market_research_country_cd STRING(2) NOT NULL
OPTIONS(description='The code which identifies a country_2 (as defined by a provider of market research data)'),
market_research_data_src_segment_name STRING(100) NOT NULL
OPTIONS(description='The name by which the segment of a market data report is known.'),
market_research_data_src_segment_display_name STRING(100)
OPTIONS(description='The name of the segment of a market data report, as defined by business.'),
market_research_data_src_segment_descr STRING(250)
OPTIONS(description='A textual description for the segment of a market data report.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'),
PRIMARY KEY (market_research_data_src_segment_name, market_research_country_cd, market_research_data_src_name,
 market_research_data_provider_name) NOT ENFORCED
)
OPTIONS(description='A market data research data source may consist of several reports, e.g. one for food, one for non-food, etc.');
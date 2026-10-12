/* --------------------------------------------------------------------------------
   DDL for table: t_local_market_research_period_2
   generated from Powerdesigner on Dienstag, 6. Mai 2025 11:46:00
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_local_market_research_period_2 (
market_research_data_provider_name STRING(100) NOT NULL
OPTIONS(description='The name by which the market data provider is known.'),
market_research_data_src_name STRING(100) NOT NULL
OPTIONS(description='The name by which the market data source is known.'),
market_research_country_cd STRING(2) NOT NULL
OPTIONS(description='The code which identifies a country_2 (as defined by a provider of market research data)'),
market_research_data_src_segment_name STRING(100) NOT NULL
OPTIONS(description='The name by which the segment of a market data report is known.'),
src_period_nr STRING(100) NOT NULL
OPTIONS(description='The number by which the time period is identified by the data provider.'),
market_research_period_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for a time period that is defined by a provider of market research data.'),
market_research_period_local_name STRING(100) NOT NULL
OPTIONS(description='The name of the time period, as defined in the local market data source segment.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'),
PRIMARY KEY (src_period_nr, market_research_data_src_segment_name, market_research_country_cd,
 market_research_data_src_name, market_research_data_provider_name) NOT ENFORCED
)
OPTIONS(description='Time periods which are defined by providers of market research data, may be identified by multiple numbers, depending on the country_2 and the data source. This table associates these numbers to the (global) time perid.');
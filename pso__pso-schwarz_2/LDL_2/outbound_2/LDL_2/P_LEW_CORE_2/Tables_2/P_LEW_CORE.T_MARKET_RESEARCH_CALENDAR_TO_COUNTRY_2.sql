/* --------------------------------------------------------------------------------
   DDL for table: t_market_research_calendar_to_country_2
   generated from Powerdesigner on Dienstag, 6. Mai 2025 11:46:00
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_market_research_calendar_to_country_2 (
market_research_data_provider_name STRING(100) NOT NULL
OPTIONS(description='The name by which the market data provider is known.'),
market_research_data_src_name STRING(100) NOT NULL
OPTIONS(description='The name by which the market data source is known.'),
market_research_country_cd STRING(2) NOT NULL
OPTIONS(description='The code which identifies a country_2 (as defined by a provider of market research data)'),
market_research_calendar_name STRING(100) NOT NULL
OPTIONS(description='The name by which the custom calendar_2 is known.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'),
PRIMARY KEY (market_research_calendar_name, market_research_data_provider_name, market_research_data_src_name,
 market_research_country_cd) NOT ENFORCED
) OPTIONS(description='This relation table shows, in which countries a market research calendar_2 is used.');
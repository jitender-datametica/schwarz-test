/* --------------------------------------------------------------------------------
   DDL for table: t_market_research_data_delivery_1
   generated from Powerdesigner on Dienstag, 6. Mai 2025 11:46:00
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_market_research_data_delivery_1 (
market_research_data_provider_name STRING(100) NOT NULL
OPTIONS(description='The name by which the market data provider is known.'),
market_research_data_src_name STRING(100) NOT NULL
OPTIONS(description='The name by which the market data source is known.'),
market_research_data_src_segment_name STRING(100) NOT NULL
OPTIONS(description='The name by which the segment of a market data report is known.'),
market_research_country_cd STRING(2) NOT NULL
OPTIONS(description='The code which identifies a country_1 (as defined by a provider of market research data)'),
market_research_data_deliv_nr STRING(100) NOT NULL
OPTIONS(description='The number which inditifies the delivery of market research data for a given data provider, data source and country.'),
ref_dt DATE OPTIONS(description='The reference date to which the data delivery is related.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'),
PRIMARY KEY (market_research_data_src_segment_name, market_research_country_cd, market_research_data_src_name,
 market_research_data_provider_name, market_research_data_deliv_nr) NOT ENFORCED
) OPTIONS(description='Market research data gets delivered as batches of files / databases.');
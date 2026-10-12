/* --------------------------------------------------------------------------------
   DDL for table: t_market_research_channel_2
   generated from Powerdesigner on Dienstag, 6. Mai 2025 11:46:00
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_market_research_channel_2 (
market_research_channel_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for a sales_2 channel that is defined by a provider of market research data.'),
market_research_channel_name STRING(100) NOT NULL
OPTIONS(description='The name of the sales_2 channel, as it has been defined by a provider of market research data.'),
channel_involvement_type_cd STRING(100) NOT NULL
OPTIONS(description='The code identifying the way, how the own organization is involved in the market research channel. Lidl can be included in the channel, Lidl may not be part of the channel, the channel may represent Lidl only or the channel is not applicable for Lidl.'),
market_research_data_provider_name STRING(100)
OPTIONS(description='The name by which the market data provider is known.'),
market_research_data_src_name STRING(100) OPTIONS(description='The name by which the market data source is known.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'),
PRIMARY KEY (market_research_channel_sid) NOT ENFORCED
)
OPTIONS(description='The sales_2 channel, as defined by providers of market research data. E.g. large supermarkets, hypermarkets, discounters, etc.');
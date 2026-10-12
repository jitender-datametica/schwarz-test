CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_market_research_channel (market_research_channel_sid
OPTIONS(description='The unique identifier (surrogate key) for a sales channel that is defined by a provider of market research data.'),
market_research_channel_name
OPTIONS(description='The name of the sales channel, as it has been defined by a provider of market research data.'),
channel_involvement_type_cd
OPTIONS(description='The code identifying the way, how the own organization is involved in the market research channel. Lidl can be included in the channel, Lidl may not be part of the channel, the channel may represent Lidl only or the channel is not applicable for Lidl.'),
market_research_data_provider_name OPTIONS(description='The name by which the market data provider is known.'),
market_research_data_src_name OPTIONS(description='The name by which the market data source is known.'), dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'))
OPTIONS(DESCRIPTION = `THE SALES CHANNEL, AS DEFINED BY PROVIDERS OF MARKET RESEARCH DATA. E.G. LARGE SUPERMARKETS, HYPERMARKETS, DISCOUNTERS, ETC.`)
AS SELECT market_research_channel_sid,
 market_research_channel_name,
 channel_involvement_type_cd,
 market_research_data_provider_name,
 market_research_data_src_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_market_research_channel;
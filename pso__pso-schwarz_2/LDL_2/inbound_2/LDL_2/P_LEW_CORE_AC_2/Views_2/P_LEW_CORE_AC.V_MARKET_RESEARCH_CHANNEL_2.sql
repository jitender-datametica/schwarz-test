CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_MARKET_RESEARCH_CHANNEL_2 (
   market_research_channel_sid              COMMENT 'The unique identifier (surrogate key) for a sales_2 channel that is defined by a provider of market research data.'
  ,market_research_channel_name             COMMENT 'The name of the sales_2 channel, as it has been defined by a provider of market research data.'
  ,channel_involvement_type_cd              COMMENT 'The code identifying the way, how the own organization is involved in the market research channel. Lidl can be included in the channel, Lidl may not be part of the channel, the channel may represent Lidl only or the channel is not applicable for Lidl.'
  ,market_research_data_provider_name       COMMENT 'The name by which the market data provider is known.'
  ,market_research_data_src_name            COMMENT 'The name by which the market data source is known.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'
)
COMMENT = 'The sales_2 channel, as defined by providers of market research data. E.g. large supermarkets, hypermarkets, discounters, etc.'
 AS 
    SELECT 
        market_research_channel_sid,
        market_research_channel_name,
        channel_involvement_type_cd,
        market_research_data_provider_name,
        market_research_data_src_name,
        dwh_load_id,
        dwh_created,
        dwh_updated

FROM P_LEW_CORE.T_MARKET_RESEARCH_CHANNEL_2 ;
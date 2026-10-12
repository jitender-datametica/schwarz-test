CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_MARKET_RESEARCH_BENCHMARK_CHANNEL_2 (
   market_research_data_provider_name       COMMENT 'The name by which the market data provider is known.'
  ,market_research_data_src_name            COMMENT 'The name by which the market data source is known.'
  ,market_research_country_cd               COMMENT 'The code which identifies a country_2 (as defined by a provider of market research data)'
  ,market_research_data_src_segment_name    COMMENT 'The name by which the segment of a market data report is known.'
  ,market_research_channel_sid              COMMENT 'The unique identifier (surrogate key) for a sales_2 channel that is defined by a provider of market research data.'
  ,default_benchmark_channel_fg             COMMENT 'An indicator, showing if this channel is the default benchmark channel for the given segment.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'
)
COMMENT = 'A segment of a market research data source may define one or several benchmark channels. These channels are used as reference to compare against. Typically, the country_2-level channels which does not include Lidl are used as benchmark. One of these channels is marked as the default channel.'
 AS 
    SELECT 
        market_research_data_provider_name,
        market_research_data_src_name,
        market_research_country_cd,
        market_research_data_src_segment_name,
        market_research_channel_sid,
        default_benchmark_channel_fg,
        dwh_load_id,
        dwh_created,
        dwh_updated

FROM P_LEW_CORE.T_MARKET_RESEARCH_BENCHMARK_CHANNEL_2 ;
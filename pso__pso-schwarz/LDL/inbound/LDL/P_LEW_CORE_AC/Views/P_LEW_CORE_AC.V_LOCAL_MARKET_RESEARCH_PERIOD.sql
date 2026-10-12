CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_LOCAL_MARKET_RESEARCH_PERIOD (
   market_research_data_provider_name       COMMENT 'The name by which the market data provider is known.'
  ,market_research_data_src_name            COMMENT 'The name by which the market data source is known.'
  ,market_research_country_cd               COMMENT 'The code which identifies a country (as defined by a provider of market research data)'
  ,market_research_data_src_segment_name    COMMENT 'The name by which the segment of a market data report is known.'
  ,src_period_nr                            COMMENT 'The number by which the time period is identified by the data provider.'
  ,market_research_period_sid               COMMENT 'The unique identifier (surrogate key) for a time period that is defined by a provider of market research data.'
  ,market_research_period_local_name        COMMENT 'The name of the time period, as defined in the local market data source segment.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'
)
COMMENT = 'Time periods which are defined by providers of market research data, may be identified by multiple numbers, depending on the country and the data source. This table associates these numbers to the (global) time perid.'
 AS 
    SELECT 
        market_research_data_provider_name,
        market_research_data_src_name,
        market_research_country_cd,
        market_research_data_src_segment_name,
        src_period_nr,
        market_research_period_sid,
        market_research_period_local_name,
        dwh_load_id,
        dwh_created,
        dwh_updated

FROM P_LEW_CORE.T_LOCAL_MARKET_RESEARCH_PERIOD ;
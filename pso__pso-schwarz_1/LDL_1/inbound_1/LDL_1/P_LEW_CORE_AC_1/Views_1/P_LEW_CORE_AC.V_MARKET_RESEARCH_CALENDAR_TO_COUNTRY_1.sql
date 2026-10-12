CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_MARKET_RESEARCH_CALENDAR_TO_COUNTRY_1 (
   market_research_data_provider_name       COMMENT 'The name by which the market data provider is known.'
  ,market_research_data_src_name            COMMENT 'The name by which the market data source is known.'
  ,market_research_country_cd               COMMENT 'The code which identifies a country_1 (as defined by a provider of market research data)'
  ,market_research_calendar_name            COMMENT 'The name by which the custom calendar_1 is known.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'
)
COMMENT = 'This relation table shows, in which countries a market research calendar_1 is used.'
 AS 
    SELECT 
        market_research_data_provider_name,
        market_research_data_src_name,
        market_research_country_cd,
        market_research_calendar_name,
        dwh_load_id,
        dwh_created,
        dwh_updated

FROM P_LEW_CORE.T_MARKET_RESEARCH_CALENDAR_TO_COUNTRY_1 ;
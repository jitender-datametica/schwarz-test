CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_MARKET_RESEARCH_DATA_SOURCE_PER_COUNTRY (
   market_research_data_provider_name       COMMENT 'The name by which the market data provider is known.'
  ,market_research_data_src_name            COMMENT 'The name by which the market data source is known.'
  ,market_research_country_cd               COMMENT 'The code which identifies a country (as defined by a provider of market research data)'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'
)
COMMENT = 'A market data source is provided for various countries, E.g. Nielsen Retail Panel for Greece, Slovenia and Italy.'
 AS 
    SELECT 
        market_research_data_provider_name,
        market_research_data_src_name,
        market_research_country_cd,
        dwh_load_id,
        dwh_created,
        dwh_updated

FROM P_LEW_CORE.T_MARKET_RESEARCH_DATA_SOURCE_PER_COUNTRY ;
CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_MARKET_RESEARCH_REGION_TYPE (
   market_research_data_provider_name       COMMENT 'The name by which the market data provider is known.'
  ,market_research_data_src_name            COMMENT 'The name by which the market data source is known.'
  ,market_research_region_type_cd           COMMENT 'The code identifying the kind of geographical region which has been defined by a provider of market research data.'
  ,market_research_region_type_descr        COMMENT 'A textual description for the kind of geographical region.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'
)
COMMENT = 'This minor entitiy defines the types of geographical areas which have been defined by a provider of market research data. It is used to distinguish between countries, provinces of countries and other types of geographical areas'
 AS 
    SELECT 
        market_research_data_provider_name,
        market_research_data_src_name,
        market_research_region_type_cd,
        market_research_region_type_descr,
        dwh_load_id,
        dwh_created,
        dwh_updated

FROM P_LEW_CORE.T_MARKET_RESEARCH_REGION_TYPE ;
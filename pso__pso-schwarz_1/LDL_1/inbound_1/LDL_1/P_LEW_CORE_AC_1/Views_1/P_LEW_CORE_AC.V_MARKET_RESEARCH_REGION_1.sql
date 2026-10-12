CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_MARKET_RESEARCH_REGION_1 (
   market_research_region_sid               COMMENT 'The unique identifier (surrogate key) for a geographical region_1 that has been defined by a provider of market research data.'
  ,market_research_data_provider_name       COMMENT 'The name by which the market data provider is known.'
  ,market_research_data_src_name            COMMENT 'The name by which the market data source is known.'
  ,market_research_country_cd               COMMENT 'The code which identifies a country_1 (as defined by a provider of market research data)'
  ,market_research_region_name              COMMENT 'The name of the geographical region_1, as it has been defined by a provider of market research data.'
  ,market_research_region_type_cd           COMMENT 'The code identifying the kind of geographical region_1 which has been defined by a provider of market research data.'
  ,loc_sid_wh                               COMMENT 'The unique identifier for the sales_1 company (VGES) which is represented by this market research region.'
  ,display_seq                              COMMENT 'The sort order in which the region_1 will be displayed in reports.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'
)
COMMENT = 'A geographical region_1, as defined by providers of market research data. This may include countries, provinces of a country_1 or smaller geographical areas. These regions do not necessarily need to match the standard geographical regions. However, regions which have been customized in order to match Lidl defined regions, may also be present.'
 AS 
    SELECT 
        market_research_region_sid,
        market_research_data_provider_name,
        market_research_data_src_name,
        market_research_country_cd,
        market_research_region_name,
        market_research_region_type_cd,
        loc_sid_wh,
        display_seq,
        dwh_load_id,
        dwh_created,
        dwh_updated

FROM P_LEW_CORE.T_MARKET_RESEARCH_REGION_1 ;
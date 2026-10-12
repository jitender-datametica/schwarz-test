CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_MARKET_RESEARCH_PRODUCT_FEATURE_TYPE_1 (
   feature_sid                              COMMENT 'The unique identifier (surrogate key) for the kind of property which is defined for a product (as defined by a market data provider).'
  ,feature_cd                               COMMENT 'The code identifying the kind of property which is defined for a product (as defined by a market data provider).'
  ,feature_descr                            COMMENT 'A textual description for the kind of property which is defined for a product (as defined by a market data provider).'
  ,market_research_data_provider_name       COMMENT 'The name by which the market data provider is known.'
  ,market_research_data_src_name            COMMENT 'The name by which the market data source is known.'
  ,market_research_country_cd               COMMENT 'The code which identifies a country_1 (as defined by a provider of market research data)'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'
)
COMMENT = 'This lookup table defines the kinds of properties which can be tracked for products. The feature is identified by its code, however this code is unique only within one market data source and country.'
 AS 
    SELECT 
        feature_sid,
        feature_cd,
        feature_descr,
        market_research_data_provider_name,
        market_research_data_src_name,
        market_research_country_cd,
        dwh_load_id,
        dwh_created,
        dwh_updated

FROM P_LEW_CORE.T_MARKET_RESEARCH_PRODUCT_FEATURE_TYPE_1 ;
CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_MARKET_RESEARCH_PRODUCT_TYPE (
   market_research_data_provider_name       COMMENT 'The name by which the market data provider is known.'
  ,market_research_data_src_name            COMMENT 'The name by which the market data source is known.'
  ,market_research_prod_type_cd             COMMENT 'The code identifying the level on which a product is defined by a provider of market data.'
  ,market_research_prod_type_descr          COMMENT 'A textual description for the level on which a product is defined by a provider of market data.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'
)
COMMENT = 'This minor entitiy defines the levels on which products get defined by a provider of market research data. Levels include GTIN, products, brands, product groups, etc.'
 AS 
    SELECT 
        market_research_data_provider_name,
        market_research_data_src_name,
        market_research_prod_type_cd,
        market_research_prod_type_descr,
        dwh_load_id,
        dwh_created,
        dwh_updated

FROM P_LEW_CORE.T_MARKET_RESEARCH_PRODUCT_TYPE ;
CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_MARKET_RESEARCH_PRODUCT_FEATURE (
   client_id                                COMMENT 'Surrogate Key CLIENT. Set to the international client.'
  ,market_research_prod_sid                 COMMENT 'The unique identifier (surrogate key) for a product that is defined by a provider of market research data.'
  ,feature_sid                              COMMENT 'The unique identifier (surrogate key) for the kind of property which is defined for a product (as defined by a market data provider).'
  ,market_research_prod_feature_txt         COMMENT 'The value for the property that is defined by the feature code.'
  ,dwh_valid_from                           COMMENT 'Begin of the validity interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'
  ,dwh_valid_to                             COMMENT 'End of the validity interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'
  ,deleted_fg                               COMMENT 'Deleted_fg = 1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'
)
COMMENT = 'A product - as it is defined by a market research data provider - may have several properties. The kind of property is defined by the feature code.'
 AS 
    SELECT 
        client_id,
        market_research_prod_sid,
        feature_sid,
        market_research_prod_feature_txt,
        dwh_valid_from,
        dwh_valid_to,
        deleted_fg,
        dwh_load_id,
        dwh_created,
        dwh_updated

FROM P_LEW_CORE.T_MARKET_RESEARCH_PRODUCT_FEATURE ;
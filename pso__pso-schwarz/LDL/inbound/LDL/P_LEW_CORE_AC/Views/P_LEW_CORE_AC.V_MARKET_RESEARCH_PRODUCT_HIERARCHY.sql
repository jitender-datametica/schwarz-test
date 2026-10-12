CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_MARKET_RESEARCH_PRODUCT_HIERARCHY (
   client_id                                COMMENT 'Surrogate Key CLIENT. Set to the international client.'
  ,market_research_prod_sid                 COMMENT 'The unique identifier (surrogate key) for a product that is defined by a provider of market research data.'
  ,market_research_prod_hierarchy_type_cd   COMMENT 'The code identifying the kind of hierarchy for market research products.'
  ,rel_market_research_prod_sid             COMMENT 'The unique identifier (surrogate key) of the related market research product in a different level of the hierarchy.'
  ,dwh_valid_from                           COMMENT 'Begin of the validity interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'
  ,dwh_valid_to                             COMMENT 'End of the validity interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'
  ,deleted_fg                               COMMENT 'Deleted_fg = 1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'
)
COMMENT = 'Products that are defined by providers of market research data, may form a hierarchy. (Note that the measures which are related to the various hierarchy levels are not necessarily consistent.) This table relates a product to another product in a different level of the hierarchy. There can be multiple hierarchy trees. The hierarchy type defines the hierarchy tree.'
 AS 
    SELECT 
        client_id,
        market_research_prod_sid,
        market_research_prod_hierarchy_type_cd,
        rel_market_research_prod_sid,
        dwh_valid_from,
        dwh_valid_to,
        deleted_fg,
        dwh_load_id,
        dwh_created,
        dwh_updated

FROM P_LEW_CORE.T_MARKET_RESEARCH_PRODUCT_HIERARCHY ;
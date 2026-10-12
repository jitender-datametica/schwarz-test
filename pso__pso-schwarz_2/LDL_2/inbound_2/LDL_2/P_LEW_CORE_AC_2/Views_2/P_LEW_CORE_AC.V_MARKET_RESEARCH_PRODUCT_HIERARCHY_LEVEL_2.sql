CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_MARKET_RESEARCH_PRODUCT_HIERARCHY_LEVEL_2 (
   client_id                                COMMENT 'Surrogate Key CLIENT. Set to the international client.'
  ,market_research_prod_hierarchy_type_cd   COMMENT 'The code identifying the kind of hierarchy_2 for market research products.'
  ,market_research_prod_type_cd             COMMENT 'The code identifying the level on which a product is defined by a provider of market data.'
  ,market_research_data_provider_name       COMMENT 'The name by which the market data provider is known.'
  ,market_research_data_src_name            COMMENT 'The name by which the market data source is known.'
  ,hierarchy_lvl_seq                        COMMENT 'The level which this product type forms in the given hierarchy. Level 1 is the lowest level.'
  ,dwh_valid_from                           COMMENT 'Begin of the validity_2 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'
  ,dwh_valid_to                             COMMENT 'End of the validity_2 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'
  ,deleted_fg                               COMMENT 'Deleted_fg = 1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'
)
COMMENT = 'This table stores the relation between a given hierarchy_2 type and the product types which form the hierarchy.'
 AS 
    SELECT 
        client_id,
        market_research_prod_hierarchy_type_cd,
        market_research_prod_type_cd,
        market_research_data_provider_name,
        market_research_data_src_name,
        hierarchy_lvl_seq,
        dwh_valid_from,
        dwh_valid_to,
        deleted_fg,
        dwh_load_id,
        dwh_created,
        dwh_updated

FROM P_LEW_CORE.T_MARKET_RESEARCH_PRODUCT_HIERARCHY_LEVEL_2 ;
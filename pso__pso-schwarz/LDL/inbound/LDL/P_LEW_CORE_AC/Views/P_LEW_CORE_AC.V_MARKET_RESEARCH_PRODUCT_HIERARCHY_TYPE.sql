CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_MARKET_RESEARCH_PRODUCT_HIERARCHY_TYPE (
   market_research_prod_hierarchy_type_cd   COMMENT 'The code identifying the kind of hierarchy for market research products.'
  ,market_research_prod_hierarchy_type_display_name COMMENT 'The name for the kind of hierarchy of market research products, as defined by business.'
  ,market_research_prod_hierarchy_type_descr COMMENT 'A textual description for kind of hierarchy of market research products.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'
)
COMMENT = 'This minor entity defines the kind of hierarchy of market research products.'
 AS 
    SELECT 
        market_research_prod_hierarchy_type_cd,
        market_research_prod_hierarchy_type_display_name,
        market_research_prod_hierarchy_type_descr,
        dwh_load_id,
        dwh_created,
        dwh_updated

FROM P_LEW_CORE.T_MARKET_RESEARCH_PRODUCT_HIERARCHY_TYPE ;
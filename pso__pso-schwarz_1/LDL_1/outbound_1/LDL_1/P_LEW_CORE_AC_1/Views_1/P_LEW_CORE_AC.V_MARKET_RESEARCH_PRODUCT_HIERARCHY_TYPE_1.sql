CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_market_research_product_hierarchy_type_1 (market_research_prod_hierarchy_type_cd
OPTIONS(description='The code identifying the kind of hierarchy_1 for market research products.'),
market_research_prod_hierarchy_type_display_name
OPTIONS(description='The name for the kind of hierarchy_1 of market research products, as defined by business.'),
market_research_prod_hierarchy_type_descr
OPTIONS(description='A textual description for kind of hierarchy_1 of market research products.'), dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'))
OPTIONS(DESCRIPTION = `THIS MINOR ENTITY DEFINES THE KIND OF HIERARCHY_1 OF MARKET RESEARCH PRODUCTS.`) AS SELECT
 market_research_prod_hierarchy_type_cd,
 market_research_prod_hierarchy_type_display_name,
 market_research_prod_hierarchy_type_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_market_research_product_hierarchy_type_1;
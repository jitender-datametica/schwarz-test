CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_market_research_product_hierarchy_1 (client_id
OPTIONS(description='Surrogate Key CLIENT. Set to the international client.'), market_research_prod_sid
OPTIONS(description='The unique identifier (surrogate key) for a product that is defined by a provider of market research data.'),
market_research_prod_hierarchy_type_cd
OPTIONS(description='The code identifying the kind of hierarchy_1 for market research products.'),
rel_market_research_prod_sid
OPTIONS(description='The unique identifier (surrogate key) of the related market research product in a different level of the hierarchy.'),
dwh_valid_from
OPTIONS(description='Begin of the validity_1 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to
OPTIONS(description='End of the validity_1 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
deleted_fg
OPTIONS(description='Deleted_fg = 1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to.'),
dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'))
OPTIONS(DESCRIPTION = `PRODUCTS THAT ARE DEFINED BY PROVIDERS OF MARKET RESEARCH DATA, MAY FORM A HIERARCHY. (NOTE THAT THE MEASURES WHICH ARE RELATED TO THE VARIOUS HIERARCHY_1 LEVELS ARE NOT NECESSARILY CONSISTENT.) THIS TABLE RELATES A PRODUCT TO ANOTHER PRODUCT IN A DIFFERENT LEVEL OF THE HIERARCHY. THERE CAN BE MULTIPLE HIERARCHY_1 TREES. THE HIERARCHY_1 TYPE DEFINES THE HIERARCHY_1 TREE.`)
AS SELECT client_id,
 market_research_prod_sid,
 market_research_prod_hierarchy_type_cd,
 rel_market_research_prod_sid,
 dwh_valid_from,
 dwh_valid_to,
 deleted_fg,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_market_research_product_hierarchy_1;
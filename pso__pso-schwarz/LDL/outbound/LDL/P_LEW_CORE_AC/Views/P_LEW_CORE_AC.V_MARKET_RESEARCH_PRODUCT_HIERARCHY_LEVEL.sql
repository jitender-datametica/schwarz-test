CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_market_research_product_hierarchy_level (client_id
OPTIONS(description='Surrogate Key CLIENT. Set to the international client.'), market_research_prod_hierarchy_type_cd
OPTIONS(description='The code identifying the kind of hierarchy for market research products.'),
market_research_prod_type_cd
OPTIONS(description='The code identifying the level on which a product is defined by a provider of market data.'),
market_research_data_provider_name OPTIONS(description='The name by which the market data provider is known.'),
market_research_data_src_name OPTIONS(description='The name by which the market data source is known.'),
hierarchy_lvl_seq
OPTIONS(description='The level which this product type forms in the given hierarchy. Level 1 is the lowest level.'),
dwh_valid_from
OPTIONS(description='Begin of the validity interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to
OPTIONS(description='End of the validity interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
deleted_fg
OPTIONS(description='Deleted_fg = 1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to.'),
dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'))
OPTIONS(DESCRIPTION = `THIS TABLE STORES THE RELATION BETWEEN A GIVEN HIERARCHY TYPE AND THE PRODUCT TYPES WHICH FORM THE HIERARCHY.`)
AS SELECT client_id,
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
FROM ldl_p_lew_core.t_market_research_product_hierarchy_level;
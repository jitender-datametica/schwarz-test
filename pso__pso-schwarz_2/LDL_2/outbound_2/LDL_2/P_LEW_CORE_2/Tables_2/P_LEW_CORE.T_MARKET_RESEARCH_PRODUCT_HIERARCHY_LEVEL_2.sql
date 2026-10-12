/* --------------------------------------------------------------------------------
   DDL for table: t_market_research_product_hierarchy_level_2
   generated from Powerdesigner on Mittwoch, 14. Mai 2025 16:14:29
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_market_research_product_hierarchy_level_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key CLIENT. Set to the international client.'),
market_research_prod_hierarchy_type_cd STRING(100) NOT NULL
OPTIONS(description='The code identifying the kind of hierarchy_2 for market research products.'),
market_research_prod_type_cd STRING(100) NOT NULL
OPTIONS(description='The code identifying the level on which a product is defined by a provider of market data.'),
market_research_data_provider_name STRING(100) NOT NULL
OPTIONS(description='The name by which the market data provider is known.'),
market_research_data_src_name STRING(100) NOT NULL
OPTIONS(description='The name by which the market data source is known.'),
hierarchy_lvl_seq BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The level which this product type forms in the given hierarchy. Level 1 is the lowest level.'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Begin of the validity_2 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='End of the validity_2 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Deleted_fg = 1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'),
PRIMARY KEY (market_research_prod_hierarchy_type_cd, market_research_prod_type_cd, market_research_data_provider_name,
 market_research_data_src_name, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='This table stores the relation between a given hierarchy_2 type and the product types which form the hierarchy.');
CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_market_research_product_type (market_research_data_provider_name
OPTIONS(description='The name by which the market data provider is known.'), market_research_data_src_name
OPTIONS(description='The name by which the market data source is known.'), market_research_prod_type_cd
OPTIONS(description='The code identifying the level on which a product is defined by a provider of market data.'),
market_research_prod_type_descr
OPTIONS(description='A textual description for the level on which a product is defined by a provider of market data.'),
dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'))
OPTIONS(DESCRIPTION = `THIS MINOR ENTITIY DEFINES THE LEVELS ON WHICH PRODUCTS GET DEFINED BY A PROVIDER OF MARKET RESEARCH DATA. LEVELS INCLUDE GTIN, PRODUCTS, BRANDS, PRODUCT GROUPS, ETC.`)
AS SELECT market_research_data_provider_name,
 market_research_data_src_name,
 market_research_prod_type_cd,
 market_research_prod_type_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_market_research_product_type;
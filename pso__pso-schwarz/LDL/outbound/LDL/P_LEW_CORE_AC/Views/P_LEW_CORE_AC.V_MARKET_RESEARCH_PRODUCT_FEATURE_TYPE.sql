CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_market_research_product_feature_type (feature_sid
OPTIONS(description='The unique identifier (surrogate key) for the kind of property which is defined for a product (as defined by a market data provider).'),
feature_cd
OPTIONS(description='The code identifying the kind of property which is defined for a product (as defined by a market data provider).'),
feature_descr
OPTIONS(description='A textual description for the kind of property which is defined for a product (as defined by a market data provider).'),
market_research_data_provider_name OPTIONS(description='The name by which the market data provider is known.'),
market_research_data_src_name OPTIONS(description='The name by which the market data source is known.'),
market_research_country_cd
OPTIONS(description='The code which identifies a country (as defined by a provider of market research data)'),
dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'))
OPTIONS(DESCRIPTION = `THIS LOOKUP TABLE DEFINES THE KINDS OF PROPERTIES WHICH CAN BE TRACKED FOR PRODUCTS. THE FEATURE IS IDENTIFIED BY ITS CODE, HOWEVER THIS CODE IS UNIQUE ONLY WITHIN ONE MARKET DATA SOURCE AND COUNTRY.`)
AS SELECT feature_sid,
 feature_cd,
 feature_descr,
 market_research_data_provider_name,
 market_research_data_src_name,
 market_research_country_cd,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_market_research_product_feature_type;
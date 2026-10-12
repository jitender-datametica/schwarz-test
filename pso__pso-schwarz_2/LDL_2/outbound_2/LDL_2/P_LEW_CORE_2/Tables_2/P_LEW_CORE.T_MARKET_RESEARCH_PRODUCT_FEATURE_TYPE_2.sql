/* --------------------------------------------------------------------------------
   DDL for table: t_market_research_product_feature_type_2
   generated from Powerdesigner on Mittwoch, 14. Mai 2025 16:16:42
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_market_research_product_feature_type_2 (
feature_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the kind of property which is defined for a product (as defined by a market data provider).'),
feature_cd STRING(100) NOT NULL
OPTIONS(description='The code identifying the kind of property which is defined for a product (as defined by a market data provider).'),
feature_descr STRING(250)
OPTIONS(description='A textual description for the kind of property which is defined for a product (as defined by a market data provider).'),
market_research_data_provider_name STRING(100)
OPTIONS(description='The name by which the market data provider is known.'),
market_research_data_src_name STRING(100) OPTIONS(description='The name by which the market data source is known.'),
market_research_country_cd STRING(2)
OPTIONS(description='The code which identifies a country_2 (as defined by a provider of market research data)'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'),
PRIMARY KEY (feature_sid) NOT ENFORCED
)
OPTIONS(description='This lookup table defines the kinds of properties which can be tracked for products. The feature is identified by its code, however this code is unique only within one market data source and country.');
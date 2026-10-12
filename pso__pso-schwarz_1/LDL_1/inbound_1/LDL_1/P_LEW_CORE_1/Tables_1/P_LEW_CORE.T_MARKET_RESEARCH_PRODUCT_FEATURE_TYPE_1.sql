/* --------------------------------------------------------------------------------
   DDL for table: t_market_research_product_feature_type_1
   generated from Powerdesigner on Mittwoch, 14. Mai 2025 16:16:42
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_MARKET_RESEARCH_PRODUCT_FEATURE_TYPE_1 (
   feature_sid                         NUMBER(38,0)     NOT NULL COMMENT 'The unique identifier (surrogate key) for the kind of property which is defined for a product (as defined by a market data provider).',
   feature_cd                          VARCHAR(100)     NOT NULL COMMENT 'The code identifying the kind of property which is defined for a product (as defined by a market data provider).',
   feature_descr                       VARCHAR(250)     COMMENT 'A textual description for the kind of property which is defined for a product (as defined by a market data provider).',
   market_research_data_provider_name  VARCHAR(100)     COMMENT 'The name by which the market data provider is known.',
   market_research_data_src_name       VARCHAR(100)     COMMENT 'The name by which the market data source is known.',
   market_research_country_cd          VARCHAR(2)       COMMENT 'The code which identifies a country_1 (as defined by a provider of market research data)',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.',   
   CONSTRAINT PK_T_MARKET_RESEARCH_PRODUCT_FEATURE_TYPE PRIMARY KEY (feature_sid) NOT ENFORCED 
)  COMMENT = 'This lookup table defines the kinds of properties which can be tracked for products. The feature is identified by its code, however this code is unique only within one market data source and country.';

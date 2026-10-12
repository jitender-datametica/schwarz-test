/* --------------------------------------------------------------------------------
   DDL for table: t_market_research_product_type_1
   generated from Powerdesigner on Dienstag, 6. Mai 2025 11:46:00
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_MARKET_RESEARCH_PRODUCT_TYPE_1 (
   market_research_data_provider_name  VARCHAR(100)     NOT NULL COMMENT 'The name by which the market data provider is known.',
   market_research_data_src_name       VARCHAR(100)     NOT NULL COMMENT 'The name by which the market data source is known.',
   market_research_prod_type_cd        VARCHAR(100)     NOT NULL COMMENT 'The code identifying the level on which a product is defined by a provider of market data.',
   market_research_prod_type_descr     VARCHAR(250)     NOT NULL COMMENT 'A textual description for the level on which a product is defined by a provider of market data.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.',   
   CONSTRAINT PK_T_MARKET_RESEARCH_PRODUCT_TYPE PRIMARY KEY (market_research_prod_type_cd, market_research_data_provider_name, market_research_data_src_name) NOT ENFORCED 
)  COMMENT = 'This minor entitiy defines the levels on which products get defined by a provider of market research data. Levels include GTIN, products, brands, product groups, etc.';

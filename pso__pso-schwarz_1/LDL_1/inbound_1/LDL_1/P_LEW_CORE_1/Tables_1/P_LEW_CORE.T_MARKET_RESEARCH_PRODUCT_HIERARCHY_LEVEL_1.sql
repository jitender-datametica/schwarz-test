/* --------------------------------------------------------------------------------
   DDL for table: t_market_research_product_hierarchy_level_1
   generated from Powerdesigner on Mittwoch, 14. Mai 2025 16:14:29
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_MARKET_RESEARCH_PRODUCT_HIERARCHY_LEVEL_1 (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key CLIENT. Set to the international client.',
   market_research_prod_hierarchy_type_cd VARCHAR(100)     NOT NULL COMMENT 'The code identifying the kind of hierarchy_1 for market research products.',
   market_research_prod_type_cd        VARCHAR(100)     NOT NULL COMMENT 'The code identifying the level on which a product is defined by a provider of market data.',
   market_research_data_provider_name  VARCHAR(100)     NOT NULL COMMENT 'The name by which the market data provider is known.',
   market_research_data_src_name       VARCHAR(100)     NOT NULL COMMENT 'The name by which the market data source is known.',
   hierarchy_lvl_seq                   NUMBER(38,0)     NOT NULL COMMENT 'The level which this product type forms in the given hierarchy. Level 1 is the lowest level.',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Begin of the validity_1 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'End of the validity_1 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'Deleted_fg = 1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.',   
   CONSTRAINT PK_T_MARKET_RESEARCH_PRODUCT_HIERARCHY_LEVEL PRIMARY KEY (market_research_prod_hierarchy_type_cd, market_research_prod_type_cd, market_research_data_provider_name, market_research_data_src_name, dwh_valid_from) NOT ENFORCED 
)  COMMENT = 'This table stores the relation between a given hierarchy_1 type and the product types which form the hierarchy.';

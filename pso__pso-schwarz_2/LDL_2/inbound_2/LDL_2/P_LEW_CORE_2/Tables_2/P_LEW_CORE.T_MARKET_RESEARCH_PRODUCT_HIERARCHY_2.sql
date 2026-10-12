/* --------------------------------------------------------------------------------
   DDL for table: t_market_research_product_hierarchy_2
   generated from Powerdesigner on Dienstag, 6. Mai 2025 11:46:00
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_MARKET_RESEARCH_PRODUCT_HIERARCHY_2 (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key CLIENT. Set to the international client.',
   market_research_prod_sid            NUMBER(38,0)     NOT NULL COMMENT 'The unique identifier (surrogate key) for a product that is defined by a provider of market research data.',
   market_research_prod_hierarchy_type_cd VARCHAR(100)     NOT NULL COMMENT 'The code identifying the kind of hierarchy_2 for market research products.',
   rel_market_research_prod_sid        NUMBER(38,0)     NOT NULL COMMENT 'The unique identifier (surrogate key) of the related market research product in a different level of the hierarchy.',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Begin of the validity_2 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'End of the validity_2 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'Deleted_fg = 1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.',   
   CONSTRAINT PK_T_MARKET_RESEARCH_PRODUCT_HIERARCHY PRIMARY KEY (market_research_prod_sid, market_research_prod_hierarchy_type_cd, dwh_valid_from) NOT ENFORCED 
)  COMMENT = 'Products that are defined by providers of market research data, may form a hierarchy. (Note that the measures which are related to the various hierarchy_2 levels are not necessarily consistent.) This table relates a product to another product in a different level of the hierarchy. There can be multiple hierarchy_2 trees. The hierarchy_2 type defines the hierarchy_2 tree.';

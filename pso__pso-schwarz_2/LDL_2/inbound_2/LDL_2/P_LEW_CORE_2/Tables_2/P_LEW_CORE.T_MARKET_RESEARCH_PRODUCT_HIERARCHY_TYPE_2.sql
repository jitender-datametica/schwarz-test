/* --------------------------------------------------------------------------------
   DDL for table: t_market_research_product_hierarchy_type_2
   generated from Powerdesigner on Dienstag, 6. Mai 2025 11:46:00
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_MARKET_RESEARCH_PRODUCT_HIERARCHY_TYPE_2 (
   market_research_prod_hierarchy_type_cd VARCHAR(100)     NOT NULL COMMENT 'The code identifying the kind of hierarchy_2 for market research products.',
   market_research_prod_hierarchy_type_display_name VARCHAR(100)     COMMENT 'The name for the kind of hierarchy_2 of market research products, as defined by business.',
   market_research_prod_hierarchy_type_descr VARCHAR(250)     NOT NULL COMMENT 'A textual description for kind of hierarchy_2 of market research products.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.',   
   CONSTRAINT PK_T_MARKET_RESEARCH_PRODUCT_HIERARCHY_TYPE PRIMARY KEY (market_research_prod_hierarchy_type_cd) NOT ENFORCED 
)  COMMENT = 'This minor entity defines the kind of hierarchy_2 of market research products.';

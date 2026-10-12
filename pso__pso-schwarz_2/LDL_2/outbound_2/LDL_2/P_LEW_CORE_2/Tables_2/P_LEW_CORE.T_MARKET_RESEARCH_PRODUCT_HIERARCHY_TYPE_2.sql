/* --------------------------------------------------------------------------------
   DDL for table: t_market_research_product_hierarchy_type_2
   generated from Powerdesigner on Dienstag, 6. Mai 2025 11:46:00
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_market_research_product_hierarchy_type_2 (
market_research_prod_hierarchy_type_cd STRING(100) NOT NULL
OPTIONS(description='The code identifying the kind of hierarchy_2 for market research products.'),
market_research_prod_hierarchy_type_display_name STRING(100)
OPTIONS(description='The name for the kind of hierarchy_2 of market research products, as defined by business.'),
market_research_prod_hierarchy_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for kind of hierarchy_2 of market research products.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'),
PRIMARY KEY (market_research_prod_hierarchy_type_cd) NOT ENFORCED
) OPTIONS(description='This minor entity defines the kind of hierarchy_2 of market research products.');
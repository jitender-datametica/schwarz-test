/* --------------------------------------------------------------------------------
   DDL for table: t_item_relevance_classification_schema_2
   generated from Powerdesigner on Thursday, November 2, 2023 4:41:05 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_item_relevance_classification_schema_2 (
item_relevance_class_schema_cd STRING(100) NOT NULL
OPTIONS(description='Code of the item_2 relevance classification schema.'),
item_relevance_class_schema_name STRING(100) NOT NULL
OPTIONS(description='Name of the item_2 relevance classification schema.'),
item_relevance_class_schema_descr STRING(250) NOT NULL
OPTIONS(description='Description of the item_2 relevance classification schema.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (item_relevance_class_schema_cd) NOT ENFORCED
)
OPTIONS(description='This table contains classification schemas for the detection of the relevance of items in different situations.             Examples of schema codes are OBE for Offene Bestellungen or STA for Gesellschaftsstatus.');
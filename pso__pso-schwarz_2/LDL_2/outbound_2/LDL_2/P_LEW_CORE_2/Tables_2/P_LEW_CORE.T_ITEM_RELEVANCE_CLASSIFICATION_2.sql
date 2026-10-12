/* --------------------------------------------------------------------------------
   DDL for table: t_item_relevance_classification_2
   generated from Powerdesigner on Thursday, November 2, 2023 4:48:20 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_item_relevance_classification_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='CLIENT ID of the item.'),
item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Item_2 for which a certain relevance classification schema is valid.'),
item_relevance_class_schema_cd STRING(100) NOT NULL
OPTIONS(description='Code of the item_2 relevance classification schema.'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Beginning of the validity_2 interval of the record.'),
dwh_valid_to DATE NOT NULL OPTIONS(description='End of the validity_2 interval of the record.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (item_sid, dwh_valid_from, item_relevance_class_schema_cd) NOT ENFORCED
)
OPTIONS(description='This table contains the relation of items and classification schemas for the detection of the relevance of items in different situations.             Only valid relation records are stored.');
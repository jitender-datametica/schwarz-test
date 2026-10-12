/* --------------------------------------------------------------------------------
   DDL for table: t_item_relevance_classification_schema
   generated from Powerdesigner on Thursday, November 2, 2023 4:41:05 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_ITEM_RELEVANCE_CLASSIFICATION_SCHEMA (
   item_relevance_class_schema_cd      VARCHAR(100)     NOT NULL COMMENT 'Code of the item relevance classification schema.',
   item_relevance_class_schema_name    VARCHAR(100)     NOT NULL COMMENT 'Name of the item relevance classification schema.',
   item_relevance_class_schema_descr   VARCHAR(250)     NOT NULL COMMENT 'Description of the item relevance classification schema.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_ITEM_RELEVANCE_CLASSIFICATION_SCHEMA PRIMARY KEY (item_relevance_class_schema_cd) NOT ENFORCED 
)  COMMENT = 'This table contains classification schemas for the detection of the relevance of items in different situations.
             Examples of schema codes are OBE for Offene Bestellungen or STA for Gesellschaftsstatus.';

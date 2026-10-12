/* --------------------------------------------------------------------------------
   DDL for table: t_item_relevance_classification
   generated from Powerdesigner on Thursday, November 2, 2023 4:48:20 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_ITEM_RELEVANCE_CLASSIFICATION (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'CLIENT ID of the item.',
   item_sid                            NUMBER(38,0)     NOT NULL COMMENT 'Item for which a certain relevance classification schema is valid.',
   item_relevance_class_schema_cd      VARCHAR(100)     NOT NULL COMMENT 'Code of the item relevance classification schema.',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Beginning of the validity interval of the record.',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'End of the validity interval of the record.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_ITEM_RELEVANCE_CLASSIFICATION PRIMARY KEY (item_sid, dwh_valid_from, item_relevance_class_schema_cd) NOT ENFORCED 
)  COMMENT = 'This table contains the relation of items and classification schemas for the detection of the relevance of items in different situations.
             Only valid relation records are stored.';
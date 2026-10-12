/* --------------------------------------------------------------------------------
   DDL for table: T_CUSTOMS_PRODUCT_DOCUMENT_REL
   generated from Powerdesigner on Mittwoch, 26. April 2023 09:56:08
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_CUSTOMS_PRODUCT_DOCUMENT_REL (
   PRODUCT_SID                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the reporting product.',
   RESOURCE_ITEM_SID                   NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the resource item..',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_CUSTOMS_PRODUCT_DOCUMENT_REL PRIMARY KEY (PRODUCT_SID, RESOURCE_ITEM_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED 
)  COMMENT = 'Bridge - Associates several documents to the customs product, that are required when making a declaration to the customs authority. - Source - GS-Upload, GTS/WWT';

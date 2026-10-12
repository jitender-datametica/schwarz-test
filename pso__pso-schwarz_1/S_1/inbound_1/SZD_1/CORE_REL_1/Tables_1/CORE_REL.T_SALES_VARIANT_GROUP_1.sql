/* --------------------------------------------------------------------------------
   DDL for table: T_SALES_VARIANT_GROUP_1
   generated from Powerdesigner on Dienstag, 1. April 2025 13:51:10
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_SALES_VARIANT_GROUP_1 (
   PRODUCT_GROUP_SID                   NUMBER(38, 0)   NOT NULL COMMENT 'Major Entity - The sales_1 variant group is a special product group for sales_1 variants. - Source - LExIS',
   LANG_CD                             VARCHAR(2)      NOT NULL COMMENT 'The code identifying the language.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   SALES_VARIANT_GROUP_TYPE_CD         VARCHAR(50)     COMMENT 'The unique code of the sales_1 variant group type.',
   SALES_VARIANT_GROUP_NR              VARCHAR(250)    NOT NULL COMMENT 'The business identifier of the sales_1 variant group.',
   SALES_VARIANT_GROUP_NAME            VARCHAR(100)    NOT NULL COMMENT 'Descriptive attribute - The name of the group of products',
   SALES_VARIANT_GROUP_DESC            VARCHAR(250)    COMMENT 'Descriptive attribute - A short description of the group of products',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_SALES_VARIANT_GROUP PRIMARY KEY (PRODUCT_GROUP_SID, LANG_CD, DWH_VALID_FROM_TMSP) NOT ENFORCED 
)  COMMENT = 'Major Entity - The sales_1 variant group is a special product group for sales_1 variants. - Source - LExIS';

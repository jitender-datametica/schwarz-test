/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_ITEM_FAMILY_2
   generated from Powerdesigner on Mittwoch, 2. April 2025 13:11:33
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_ITEM_FAMILY_2 (
   PRODUCT_GROUP_SID                   NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) of the item_2 family.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   ITEM_FAMILY_NR                      VARCHAR(250)    NOT NULL COMMENT 'The business identifier of the item_2 family.',
   ITEM_FAMILY_NAME                    VARCHAR(100)    NOT NULL COMMENT 'The name of the item_2 family in the default language.',
   ITEM_FAMILY_NAME_DE                 VARCHAR(100)    COMMENT 'The german translation of the name of the item_2 family.',
   ITEM_FAMILY_NAME_EN                 VARCHAR(100)    COMMENT 'The english translation of the name of the item_2 family.',
   SUB_ITEM_GROUP_NR                   VARCHAR(250)    NOT NULL COMMENT 'The business identifier of the sub item_2 group.',
   SUB_ITEM_GROUP_NAME                 VARCHAR(100)    NOT NULL COMMENT 'The name of the sub item_2 group in the default language.',
   SUB_ITEM_GROUP_NAME_DE              VARCHAR(100)    COMMENT 'The german translation of the name of the sub item_2 group.',
   SUB_ITEM_GROUP_NAME_EN              VARCHAR(100)    COMMENT 'The english translation of the name of the sub item_2 group.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_DIM_ITEM_FAMILY PRIMARY KEY (PRODUCT_GROUP_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED 
)  COMMENT = 'Major Entity - This dimension contains all the item_2 families and their superior sub item_2 groups denormalized. - Source - SAP RAN 900';

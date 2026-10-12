/* --------------------------------------------------------------------------------
   DDL for table: T_SALES_VARIANT_GROUP_HIERARCHY_REL
   generated from Powerdesigner on Donnerstag, 27. März 2025 13:22:24
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_SALES_VARIANT_GROUP_HIERARCHY_REL (
   PRODUCT_GROUP_SID                   NUMBER(38, 0)   NOT NULL COMMENT 'Major Entity - The sales variant group is a special product group for sales variants. - Source - LExIS',
   PARENT_PRODUCT_GROUP_SID            NUMBER(38, 0)   NOT NULL COMMENT 'Major Entity - The sales variant group is a special product group for sales variants. - Source - LExIS',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path.',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source.',   
   CONSTRAINT PK_SALES_VARIANT_GROUP_HIERARCHY_REL PRIMARY KEY (PRODUCT_GROUP_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED 
)  COMMENT = 'Bridge Entity - Contains the hierarchy dependencies between sales variant groups and their parent groups. - Source - SAP LExIS';

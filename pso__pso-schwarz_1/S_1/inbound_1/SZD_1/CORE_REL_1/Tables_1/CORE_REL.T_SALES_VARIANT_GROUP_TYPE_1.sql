/* --------------------------------------------------------------------------------
   DDL for table: T_SALES_VARIANT_GROUP_TYPE_1
   generated from Powerdesigner on Donnerstag, 27. März 2025 10:46:19
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_SALES_VARIANT_GROUP_TYPE_1 (
   SALES_VARIANT_GROUP_TYPE_CD         VARCHAR(50)     NOT NULL COMMENT 'The unique code of the sales_1 variant group type.',
   SALES_VARIANT_GROUP_TYPE_NAME       VARCHAR(100)    NOT NULL COMMENT 'The name of the sales_1 variant group type.',
   SALES_VARIANT_GROUP_TYPE_DESC       VARCHAR(250)    NOT NULL COMMENT 'A brief description of the sales_1 variant group type.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path.',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source.',   
   CONSTRAINT PK_SALES_VARIANT_GROUP_TYPE PRIMARY KEY (SALES_VARIANT_GROUP_TYPE_CD) NOT ENFORCED 
)  COMMENT = 'Minor Entity - Describes the type of the sales_1 variant group. Different types of sales_1 variant group can be related in a hierarchy. - Source - Manual';

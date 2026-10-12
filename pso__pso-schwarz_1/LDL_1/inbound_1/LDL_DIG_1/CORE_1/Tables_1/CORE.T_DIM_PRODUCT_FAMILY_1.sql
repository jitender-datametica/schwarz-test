/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_PRODUCT_FAMILY_1
   GENERATED FROM POWERDESIGNER ON Montag, 13. März 2023 16:31:09
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_PRODUCT_FAMILY_1 (
   PROD_FAMILY_CD                      VARCHAR(20)     NOT NULL COMMENT 'The product Family Code represents the lower level of granularity of the Product Categories (sub_prod_group_cd).',
   PROD_FAMILY_DESCR                   VARCHAR(100)    COMMENT 'Product family description',
   PROD_SUBGROUP_CD                    VARCHAR(5)      COMMENT 'The product subgroup code describes the category a product is part of. Such as "baby clothes" or "Workshop - Machines" etc.',
   PROD_GROUP_CD                       VARCHAR(20)     COMMENT 'Code of warengruppe - one of the LD classification for the products (DMM165-013, DMM165-014 , etc)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_PRODUCT_FAMILY PRIMARY KEY (PROD_FAMILY_CD) NOT ENFORCED
 )  COMMENT= 'This minor dimension containts information about product families and the product subgroups and groups these families belong to.';

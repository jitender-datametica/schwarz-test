/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_PRODUCT_SUBGROUP_2
   GENERATED FROM POWERDESIGNER ON Montag, 13. März 2023 16:31:25
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_PRODUCT_SUBGROUP_2 (
   PROD_SUBGROUP_CD                    VARCHAR(5)      NOT NULL COMMENT 'The product subgroup code describes the category a product is part of. Such as "baby clothes" or "Workshop - Machines" etc.',
   PROD_SUBGROUP_DESCR                 VARCHAR(100)    COMMENT 'Product subgroup description',
   PROD_GROUP_CD                       VARCHAR(20)     COMMENT 'Code of warengruppe - one of the LD classification for the products (DMM165-013, DMM165-014 , etc)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_PRODUCT_SUBGROUP PRIMARY KEY (PROD_SUBGROUP_CD) NOT ENFORCED
 )  COMMENT= 'This minor dimension containts information about all different product subgroups (Unterwarengruppen). A product subgroup is a parent of product family and a child of product group';

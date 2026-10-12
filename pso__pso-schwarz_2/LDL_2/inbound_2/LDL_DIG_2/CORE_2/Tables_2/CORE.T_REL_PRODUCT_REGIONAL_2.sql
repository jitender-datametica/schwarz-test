/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_REL_PRODUCT_REGIONAL_2
   GENERATED FROM POWERDESIGNER ON Donnerstag, 19. September 2024 10:38:54
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_REL_PRODUCT_REGIONAL_2 (
   WSHOP_CD                            VARCHAR(5)      NOT NULL COMMENT 'The unique code for the Lidl webshop',
   PROD_SID                            NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the product',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   PROD_NR                             VARCHAR(20)     COMMENT 'The number for internal onlineshop product',
   REG_PROD_NAME                       VARCHAR(100)    COMMENT 'The product name that is defined per country_2',
   REG_PROD_DESCR                      VARCHAR(250)    COMMENT 'The regional product information in a free text form',
   PROD_FAMILY_CD                      VARCHAR(20)     COMMENT 'The code representing the lower level of granularity of the Product Categories (prod_subgroup_cd).',
   REG_PROD_MANAGER_CD                 VARCHAR(10)     COMMENT 'A code indentifiyng the regional product manager.',
   DELIVERY_SRC_TYPE_CD                VARCHAR(5)      COMMENT 'The code for source location_2 of product from where it is delivered i.e. from supplier_2 or warehouse directly',
   MATERIAL_POS_TYPE_CD                VARCHAR(5)      COMMENT 'The code for the process type a product can be assigned to (e.g NORM, BANS).',
   SHOP_CAT_SID                        NUMBER          COMMENT 'The original shop category code',
   SHOP_CAT_NAME                       VARCHAR(250)    COMMENT 'The name by which the original shop category is known.',
   SHOP_CAT_LVL4_SID                   NUMBER          COMMENT 'The unique identifier (surrogate key) for shop category level 4',
   SHOP_CAT_LVL4_NAME                  VARCHAR(100)    COMMENT 'The name by which the shop category level 4 is known.',
   SHOP_CAT_LVL3_SID                   NUMBER          COMMENT 'The unique identifier (surrogate key) for shop category level 3',
   SHOP_CAT_LVL3_NAME                  VARCHAR(100)    COMMENT 'The name by which the shop category level 3 is known.',
   SHOP_CAT_LVL2_SID                   NUMBER          COMMENT 'The unique identifier (surrogate key) for shop category level 2',
   SHOP_CAT_LVL2_NAME                  VARCHAR(100)    COMMENT 'The name by which the shop category level 2 is known.',
   SHOP_CAT_LVL1_SID                   NUMBER          COMMENT 'The unique identifier (surrogate key) for shop category level 1',
   SHOP_CAT_LVL1_NAME                  VARCHAR(100)    COMMENT 'The name by which the shop category level 1 is known.',
   SHOP_CAT_LVL4_CD                    NUMBER          COMMENT 'The code by which the shop category level 4 is known.',
   SHOP_CAT_LVL3_CD                    NUMBER          COMMENT 'The code by which the shop category level 3 is known.',
   SHOP_CAT_LVL2_CD                    NUMBER          COMMENT 'The code by which the shop category level 2 is known.',
   SHOP_CAT_LVL1_CD                    NUMBER          COMMENT 'The code by which the shop category level 1 is known.',
   TAX_CLASS_CD                        VARCHAR(5)      COMMENT 'The code identifying the tax class',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source tables',   
   CONSTRAINT PK_T_REL_PRODUCT_REGIONAL PRIMARY KEY (PROD_SID, DWH_VALID_FROM_TMSP, WSHOP_CD) NOT ENFORCED 
)  COMMENT = 'For a product, attributes can be different in different countries';

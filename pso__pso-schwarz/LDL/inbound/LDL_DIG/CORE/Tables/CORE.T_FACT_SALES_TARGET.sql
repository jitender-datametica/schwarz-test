/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_SALES_TARGET
   GENERATED FROM POWERDESIGNER ON Mittwoch, 21. Februar 2024 17:30:41
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_SALES_TARGET (
   WSHOP_CD                            VARCHAR(5)      NOT NULL COMMENT 'The unique code for the Lidl webshop',
   TARGET_SALE_DT                      DATE            NOT NULL COMMENT 'A date for which the target is set by headquarter',
   DELIVERY_SRC_TYPE_CD                VARCHAR(5)      NOT NULL COMMENT 'The code for source location of product from where it is delivered i.e. from supplier or warehouse directly',
   PROD_ASSORTMENT_CLASS_CD            VARCHAR(5)      NOT NULL COMMENT 'The code for the indicating if product is a part of special offer or normal or special assortiment',
   PROD_FOOD_CLASS_CD                  VARCHAR(5)      NOT NULL COMMENT 'The code for the indicating if product is a food or non food',
   BRAND_CLASS_CD                      VARCHAR(5)      NOT NULL COMMENT 'The code for the indicating if product is classified as a Lidl own brand or not',
   SHOP_CAT_LVL1_SID                   NUMBER          NOT NULL COMMENT 'The unique identifier (sk) for global shop category level 1',
   SHOP_CAT_LVL1_NAME                  VARCHAR(100)    COMMENT 'The name by which the  global  shop category level 1 is known.',
   TGT_PROD_SALE_QTY                   NUMBER(38, 0)   COMMENT 'Number of products expected to be sold. Product quantities in stock units (no decimal values).',
   TGT_REVENUE_NET_EUR_VAL             NUMBER(38, 5)   COMMENT 'A target sales amount for a level netto in euro',
   TGT_MARGIN_EUR_VAL                  NUMBER(38, 5)   COMMENT 'A target margin amount for a  level  in euro',
   CURR_CD                             VARCHAR(5)      COMMENT 'The code identifying the currency according to ISO-4217.',
   PROD_ORG_LVL_NAME                   VARCHAR(50)     COMMENT 'The Organisation level of a product corresponds to the Lidl Digital structure which owns - or is responsible for - these articles (product variants) in the organization.',
   SHOP_CAT_LVL1_CD                    NUMBER          COMMENT 'The code by which the shop category level 1 is known.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_FACT_SALES_TARGET PRIMARY KEY (WSHOP_CD, TARGET_SALE_DT, DELIVERY_SRC_TYPE_CD, PROD_ASSORTMENT_CLASS_CD, PROD_FOOD_CLASS_CD, BRAND_CLASS_CD, SHOP_CAT_LVL1_SID) NOT ENFORCED 
)  COMMENT = 'An daily target sales amount  is set for every product sold in a Lidl webshop';

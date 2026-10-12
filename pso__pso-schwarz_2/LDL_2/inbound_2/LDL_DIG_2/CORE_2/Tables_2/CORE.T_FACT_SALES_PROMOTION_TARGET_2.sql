CREATE TABLE CORE.T_FACT_SALES_PROMOTION_TARGET_2 (
   WSHOP_CD                            VARCHAR(5)      NOT NULL COMMENT 'The unique code for the Lidl webshop',
   PROD_SID                            NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the product',
   PROMO_DT                            DATE            NOT NULL COMMENT 'Promotion Start Date for offline stores',
   SALE_PROMO_TYPE_CD                  VARCHAR(25)     COMMENT 'The way the product gets promoted e.g. website, flyer, etc.',
   CURR_CD                             VARCHAR(5)      COMMENT 'The code identifying the currency according to ISO-4217.',
   PROMO_PRICE_GROSS_LOCAL_VAL         NUMBER(38, 5)   COMMENT 'Promotion Selling Price - Gross Value',
   TGT_PROD_SALE_QTY                   NUMBER(38, 0)   COMMENT 'Number of products expected to be sold. Product quantities in stock units (no decimal values).',
   PROMO_DUR_WEEK_CNT                  NUMBER          COMMENT 'How long was the promotion planned to be active (number of weeks)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   PROD_NR                             VARCHAR(20)     COMMENT 'The number for internal onlineshop product, which is country_2 independent',
   CONSTRAINT PK_T_FACT_SALES_PROMOTION_TARG PRIMARY KEY (WSHOP_CD, PROD_SID, PROMO_DT)
       NOT ENFORCED
)COMMENT = 'Products are being promoted/advertised in different platforms, it is expected to have a certain number of products being sold';

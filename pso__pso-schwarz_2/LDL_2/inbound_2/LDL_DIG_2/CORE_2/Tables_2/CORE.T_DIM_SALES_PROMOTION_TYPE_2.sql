CREATE TABLE CORE.T_DIM_SALES_PROMOTION_TYPE_2 (
   SALE_PROMO_TYPE_CD                  VARCHAR(25)     NOT NULL COMMENT 'The unique code for that defines the way the product gets promoted e.g. website, flyer, etc.',
   SALE_PROMO_TYPE_NAME                VARCHAR(100)    COMMENT 'The name for the promotion type in group language',
   SALE_PROMO_TYPE_DESCR               VARCHAR(250)    COMMENT 'The textual description for the promotion type in group language',
   SALE_PROMO_TYPE_DESCR_EN            VARCHAR(250)    DEFAULT '' COMMENT 'The textual description for the promotion type in English',
   SALE_PROMO_TYPE_DESCR_DE            VARCHAR(250)    DEFAULT '' COMMENT 'The textual description for the promotion type in German',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_SALES_PROMOTION_TYPE PRIMARY KEY (SALE_PROMO_TYPE_CD) NOT ENFORCED
 )  COMMENT= 'This minor dimension defines the way the product gets promoted e.g. website, flyer, etc. ( Bestellmagazin, Online Only etc)';

/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_SALES_PROMOTION_STATUS_2
   GENERATED FROM POWERDESIGNER ON Mittwoch, 22. Juni 2022 14:42:49
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_SALES_PROMOTION_STATUS_2 (
   SALE_PROMO_STATUS_CD                VARCHAR(25)     NOT NULL COMMENT 'The unique code for the status_2 of a promotion/delivery.',
   SALE_PROMO_STATUS_DESCR             VARCHAR(250)    NOT NULL COMMENT 'The textual description for the status_2 of a promotion/delivery.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_SALES_PROMOTION_STATUS PRIMARY KEY (SALE_PROMO_STATUS_CD) NOT ENFORCED
 )  COMMENT= 'This minor dimension describes the status_2 of a promotion/delivery';

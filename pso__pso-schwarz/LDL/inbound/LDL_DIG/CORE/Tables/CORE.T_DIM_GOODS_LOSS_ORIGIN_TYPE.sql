/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_GOODS_LOSS_ORIGIN_TYPE
   GENERATED FROM POWERDESIGNER ON Mittwoch, 29. Juni 2022 14:45:52
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_GOODS_LOSS_ORIGIN_TYPE (
   GOODS_LOSS_ORIGIN_TYPE_CD           VARCHAR(5)      NOT NULL COMMENT 'Code identifying the event type that leads to profit or loss ( ex. PC = Price Chagne, CV = coupon validation ...)',
   GOODS_LOSS_ORIGIN_TYPE_DESCR        VARCHAR(250)    COMMENT 'Textual description of the event type that leads to profit or loss',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   CONSTRAINT PK_T_DIM_GOODS_LOSS_ORIGIN_TYPE PRIMARY KEY (GOODS_LOSS_ORIGIN_TYPE_CD) NOT ENFORCED
 )  COMMENT= 'A minor dimension that contains type of events that lead to financial profit or loss related to goods (ex  Price Change, Coupon Validation, Scrapping ) ';
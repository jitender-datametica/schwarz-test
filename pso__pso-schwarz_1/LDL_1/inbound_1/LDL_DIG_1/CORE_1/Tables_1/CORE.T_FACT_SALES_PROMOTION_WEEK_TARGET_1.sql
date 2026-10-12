CREATE TABLE CORE.T_FACT_SALES_PROMOTION_WEEK_TARGET_1 (
   WSHOP_CD                            VARCHAR(5)      NOT NULL COMMENT 'Country_1 of the promotion',
   WEEK_NR                             NUMBER(38, 0)   NOT NULL COMMENT 'For each promotion week, and depending on the promotion duration, there is a planned percentage of units to be sold. ',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   SALE_PROMO_PHASE_CD                 VARCHAR(5)      NOT NULL COMMENT 'The phase can be either A (Aktion_1) which corresponds to the first three week of a promotion, or N (Nachlauf) if it is refering to the remaining weeks - after-promotion phase.',
   PROMO_DUR_WEEK_CNT                  NUMBER(38, 0)   NOT NULL COMMENT 'How long was the promotion planned to be active (number of weeks)',
   TGT_SALE_PCT                        NUMBER(38, 5)   COMMENT 'Planned percentage of units sold for each promotion week. ',
   CUM_TGT_SALE_PCT                    NUMBER(38, 5)   COMMENT 'Cummulative planned percentage of units sold for each promotion week. ',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source tables',
   CONSTRAINT PK_T_FACT_SALES_PROMOTION_WEEK_TARGET PRIMARY KEY (WSHOP_CD, WEEK_NR, DWH_VALID_FROM_TMSP, SALE_PROMO_PHASE_CD, PROMO_DUR_WEEK_CNT) NOT ENFORCED
 )  COMMENT= 'A sales_1 target for sales_1 during promotion week by week. ';

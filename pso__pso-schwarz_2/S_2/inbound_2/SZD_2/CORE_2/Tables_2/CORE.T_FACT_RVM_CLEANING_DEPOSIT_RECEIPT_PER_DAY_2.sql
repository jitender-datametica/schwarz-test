/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_RVM_CLEANING_DEPOSIT_RECEIPT_PER_DAY_2
   generated from Powerdesigner on Montag, 10. November 2025 12:06:23
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_RVM_CLEANING_DEPOSIT_RECEIPT_PER_DAY_2 (
   RVM_SID                             NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the despotie machine which is located in a store',
   CAL_DT                              DATE            NOT NULL COMMENT 'The day represented as a calendar_2 date of the form YYYY-MM_2-DD. YYYY is the calendar_2 year, MM_2 (between 1 and 12) the calendar_2 month and DD the day of the calendar_2 month (between 1 and 31). ',
   CLEANING_TYPE_CD                    VARCHAR(50)     NOT NULL COMMENT 'The code for the cleaning type',
   CLEANING_STATUS_CD                  VARCHAR(50)     NOT NULL COMMENT 'The code for the cleaning status_2',
   DEPOSIT_RECEIPT_PRINTED_FG          BOOLEAN         NOT NULL COMMENT 'The flag showing if there was a deposit receipt printed from the RVM on a particular day.',
   CLEANING_DUR_SEC_CNT                NUMBER(38,0)    COMMENT 'The analytical fact for the cleaning duration time',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',   
   CONSTRAINT PK_T_FACT_RVM_CLEANING_DEPOSIT_RECEIPT_PER_DAY PRIMARY KEY (RVM_SID, CAL_DT, CLEANING_TYPE_CD, CLEANING_STATUS_CD) NOT ENFORCED 
)  COMMENT = 'Fact table - Analytical - Granularity by rvm, day, cleaning type and cleaning status_2 - Aggregate - Contains the data about the cleaning of a Reverse Vending Machine and whether a Deposit Receipt was also printed on the daily basis. - Source - T_FACT_RVM_CLEANING_2 and T_FACT_DEPOSIT_RECEIPT.';

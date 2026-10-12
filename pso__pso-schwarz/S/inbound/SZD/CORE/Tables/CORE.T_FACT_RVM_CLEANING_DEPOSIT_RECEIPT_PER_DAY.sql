/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_RVM_CLEANING_DEPOSIT_RECEIPT_PER_DAY
   generated from Powerdesigner on Montag, 10. November 2025 12:06:23
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_RVM_CLEANING_DEPOSIT_RECEIPT_PER_DAY (
   RVM_SID                             NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the despotie machine which is located in a store',
   CAL_DT                              DATE            NOT NULL COMMENT 'The day represented as a calendar date of the form YYYY-MM-DD. YYYY is the calendar year, MM (between 1 and 12) the calendar month and DD the day of the calendar month (between 1 and 31). ',
   CLEANING_TYPE_CD                    VARCHAR(50)     NOT NULL COMMENT 'The code for the cleaning type',
   CLEANING_STATUS_CD                  VARCHAR(50)     NOT NULL COMMENT 'The code for the cleaning status',
   DEPOSIT_RECEIPT_PRINTED_FG          BOOLEAN         NOT NULL COMMENT 'The flag showing if there was a deposit receipt printed from the RVM on a particular day.',
   CLEANING_DUR_SEC_CNT                NUMBER(38,0)    COMMENT 'The analytical fact for the cleaning duration time',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',   
   CONSTRAINT PK_T_FACT_RVM_CLEANING_DEPOSIT_RECEIPT_PER_DAY PRIMARY KEY (RVM_SID, CAL_DT, CLEANING_TYPE_CD, CLEANING_STATUS_CD) NOT ENFORCED 
)  COMMENT = 'Fact table - Analytical - Granularity by rvm, day, cleaning type and cleaning status - Aggregate - Contains the data about the cleaning of a Reverse Vending Machine and whether a Deposit Receipt was also printed on the daily basis. - Source - T_FACT_RVM_CLEANING and T_FACT_DEPOSIT_RECEIPT.';

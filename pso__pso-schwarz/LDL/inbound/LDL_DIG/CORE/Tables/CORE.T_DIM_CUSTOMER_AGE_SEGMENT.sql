/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_CUSTOMER_AGE_SEGMENT
   GENERATED FROM POWERDESIGNER ON Donnerstag, 7. Juli 2022 12:00:56
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_CUSTOMER_AGE_SEGMENT (
   CUST_AGE_SEGM_CD                    VARCHAR(20)     NOT NULL COMMENT 'The code for a customer age cluster',
   CUST_AGE_SEGM_TYPE_CD               VARCHAR(20)     NOT NULL COMMENT 'A type to distinquish customer age clustering for different departments',
   CUST_AGE_SEGM_DESCR                 VARCHAR(250)    COMMENT 'The description for a customer age cluster',
   CUST_AGE_SEGM_START_YEAR            NUMBER          COMMENT 'A start year for a particular age segment',
   CUST_AGE_SEGM_END_YEAR              NUMBER          COMMENT 'An end year for a particular age segment',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_CUSTOMER_AGE_SEGMENT PRIMARY KEY (CUST_AGE_SEGM_CD, CUST_AGE_SEGM_TYPE_CD) NOT ENFORCED
 )  COMMENT= 'This dimension defines clustering for a customer age';

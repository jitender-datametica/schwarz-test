/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_CUSTOMER_GENDER_2
   GENERATED FROM POWERDESIGNER ON Montag, 4. Juli 2022 15:35:16
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_CUSTOMER_GENDER_2 (
   CUST_GENDER_CD                      VARCHAR(20)     NOT NULL COMMENT 'The code for a gender of a customer ( M - Male , F - Female)',
   CUST_GENDER_DESCR                   VARCHAR(250)    COMMENT 'The textual description for the gender of a customer ',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_CUSTOMER_GENDER PRIMARY KEY (CUST_GENDER_CD) NOT ENFORCED
 )  COMMENT= 'This dimension describes a gender of a customer ( M - Male , F - Female)';

/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_REL_CUSTOMER_INTERNAL_COMPANY_1
   GENERATED FROM POWERDESIGNER ON Dienstag, 15. März 2022 12:57:58
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_REL_CUSTOMER_INTERNAL_COMPANY_1 (
   INTERNAL_COMPANY_SID                NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the company',
   CUST_SID                            NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the customer',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   RECONCILIATION_ACCT_NR              VARCHAR(20)     NOT NULL COMMENT 'The number of the reconciliation account_1 associated with this supplier_1 for this Lidl Company',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source tables',
   INTERNAL_COMPANY_CD                 VARCHAR(5)      COMMENT 'Unique identifier of the company to which we book accounting documents in the source system (SAP)',
   CONSTRAINT PK_T_REL_CUSTOMER_INTERNAL_COMPANY PRIMARY KEY (INTERNAL_COMPANY_SID, CUST_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED
 )  COMMENT= 'The table contains relationship between Customer and Lidl Company, plus characteristics of this relationship - like reconciliation account_1 used by the company for this customer';

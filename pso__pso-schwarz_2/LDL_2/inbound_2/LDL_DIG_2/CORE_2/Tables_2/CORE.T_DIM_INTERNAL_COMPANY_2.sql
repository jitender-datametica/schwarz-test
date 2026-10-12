/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_INTERNAL_COMPANY_2
   GENERATED FROM POWERDESIGNER ON Dienstag, 9. August 2022 12:17:57
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_INTERNAL_COMPANY_2 (
   INTERNAL_COMPANY_SID                NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the company',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   INTERNAL_COMPANY_CD                 VARCHAR(5)      COMMENT 'Unique identifier of the company to which we book accounting documents in the source system (SAP)',
   INTERNAL_COMPANY_NAME               VARCHAR(100)    COMMENT 'Name for the company code to which we book accounting  documents as in SAP system',
   COMPANY_NR                          VARCHAR(20)     COMMENT 'Unique number of the company to which we book accounting documents(number different from SAP system)',
   COMPANY_NAME                        VARCHAR(100)    COMMENT 'Name for the company code to which we book accounting  documents(name different from SAP system)',
   COUNTRY_CD                          VARCHAR(5)      COMMENT 'Code of the country_2 where this company is registered',
   WSHOP_CD                            VARCHAR(5)      COMMENT 'The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country_2 and is run by an Lidl Digital Country. If a company is not a webshop the value is NULL',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source tables',
   CONSTRAINT PK_T_DIM_INTERNAL_COMPANY PRIMARY KEY (INTERNAL_COMPANY_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED
 )  COMMENT= 'A company is an entity which is legally registered in a given country_2 and for which we track financial and accountign records.  This table includes only companies from Schwarz group.';

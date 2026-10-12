/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_INTERNAL_COMPANY_PARTNER_1
   GENERATED FROM POWERDESIGNER ON Dienstag, 9. August 2022 12:18:25
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_INTERNAL_COMPANY_PARTNER_1 (
   INTERNAL_COMPANY_PARTNER_SID        NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the internal company partner',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   INTERNAL_COMPANY_PARTNER_NR         VARCHAR(20)     COMMENT 'Unique number of the partner company (receiving or sending company)',
   INTERNAL_COMPANY_PARTNER_NAME       VARCHAR(100)    COMMENT 'Name for the internal company partner (receiving or sending company)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source tables',
   CONSTRAINT PK_T_DIM_INTERNAL_COMPANY_PARTNER PRIMARY KEY (INTERNAL_COMPANY_PARTNER_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED
 )  COMMENT= 'An internal company can have additional identifier (partner) which is used in internal trading operations (between companies of the group). Relationship between internal_company/company nr is many to many with internal company partner';

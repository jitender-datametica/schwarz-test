/* --------------------------------------------------------------------------------
   DDL for table: T_CUSTOMS_REQUESTED_PROCEDURE
   generated from Powerdesigner on Mittwoch, 26. April 2023 09:57:12
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_CUSTOMS_REQUESTED_PROCEDURE (
   REQUESTED_PROCEDURE_CD              VARCHAR(50)     NOT NULL COMMENT 'The unique code of the requested procedure code.',
   REQUESTED_PROCEDURE_DESCR           VARCHAR(250)    COMMENT 'A brief description of the requested procedure code.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_CUSTOMS_REQUESTED_PROCEDURE PRIMARY KEY (REQUESTED_PROCEDURE_CD) NOT ENFORCED 
)  COMMENT = 'Minor Entity - This code determines whether and which conditions must apply to the imported goods, for example whether they may be released for free circulation. This code contains the first 4 digits of a customs procedure code. - Source - Manual';

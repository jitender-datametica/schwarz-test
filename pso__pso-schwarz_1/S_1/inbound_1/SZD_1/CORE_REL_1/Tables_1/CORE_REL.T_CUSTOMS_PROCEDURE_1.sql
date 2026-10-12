/* --------------------------------------------------------------------------------
   DDL for table: T_CUSTOMS_PROCEDURE_1
   generated from Powerdesigner on Mittwoch, 26. April 2023 09:54:54
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_CUSTOMS_PROCEDURE_1 (
   CUSTOMS_PROCEDURE_CD                VARCHAR(50)     NOT NULL COMMENT 'The unique code of the customs procedure code.',
   REQUESTED_PROCEDURE_CD              VARCHAR(50)     NOT NULL COMMENT 'The unique code of the requested_procedure code. These are the first 4 digits of the customs procedure code.',
   ADDITIONAL_PROCEDURE_CD             VARCHAR(50)     NOT NULL COMMENT 'The unique code of the additional procedure code.',
   APPROVED_FG                         BOOLEAN         NOT NULL COMMENT 'A flag indicating this customs procedure code is approved by the importer',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_CUSTOMS_PROCEDURE PRIMARY KEY (CUSTOMS_PROCEDURE_CD) NOT ENFORCED 
)  COMMENT = 'Major Entity - The 7 digit customs procedure code contains of two components, the requested procedure code (the first 4 digits) and the additional procedure code (the last 3 digits). - Source - Manual';

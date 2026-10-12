/* --------------------------------------------------------------------------------
   DDL for table: T_CUSTOMS_ADDITIONAL_PROCEDURE_2
   generated from Powerdesigner on Mittwoch, 26. April 2023 09:49:35
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_CUSTOMS_ADDITIONAL_PROCEDURE_2 (
   ADDITIONAL_PROCEDURE_CD             VARCHAR(50)     NOT NULL COMMENT 'The unique code of the additional procedure code.',
   ADDITIONAL_PROCEDURE_DESCR          VARCHAR(250)    COMMENT 'A brief description of the additional procedure code.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_CUSTOMS_ADDITIONAL_PROCEDURE PRIMARY KEY (ADDITIONAL_PROCEDURE_CD) NOT ENFORCED 
)  COMMENT = 'Minor Entity - This code defines special behaviours with products, for example goods that are imported under diplomatic privilege (personal use). These code contains the last 3 digits of a customs procedure code - Source - Manual';

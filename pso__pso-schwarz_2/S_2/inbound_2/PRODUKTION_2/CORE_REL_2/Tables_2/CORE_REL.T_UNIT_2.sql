--==============================================================
-- Table: T_UNIT_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_UNIT_2
   generated from Powerdesigner on Tuesday, March 22, 2022 6:33:12 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_UNIT_2 (
   UNIT_ID                             NUMBER(38,0)    NOT NULL COMMENT 'Id of the unit_2 (e.g. material unit_2, production line parameter)',
   UNIT_CODE                           VARCHAR(100)    NOT NULL COMMENT 'Natural Key - Unit_2 code as a technical identifier of the unit_2 from the source system or manually maintained (e.g. degree C)',
   UNIT_NAME                           VARCHAR(100)    COMMENT 'Full name of the unit_2 (e.g. celsius degree)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(250)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
   CONSTRAINT PK_T_UNIT PRIMARY KEY (UNIT_ID) NOT ENFORCED
 )  COMMENT= 'Table with units (e.g. plastic materials, production line parameter). Source - Extracted from metadata durant data delivery process.';


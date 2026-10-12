/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_HAULER
   generated from Powerdesigner on Montag, 22. April 2024 11:13:49
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_HAULER (
   PARTY_SID                           NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the hauler (carrier )',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   HAULER_NAME                         VARCHAR(100)    NOT NULL COMMENT 'Natural Key/Business Key - name of the hauler (carrier )',
   SOURCE_HAULER_NAME_ADDRESS_CITY_TXT VARCHAR(1000)   NOT NULL COMMENT 'Descriptive Attribute - the name of the hauler directly from source. Source: VMT',
   HAULER_CD                           VARCHAR(50)     COMMENT 'Short code for a carrier name (Evergreen = EGLV for example)',
   STATUS_CD                           VARCHAR(50)     NOT NULL COMMENT 'The status code for the company',
   HAULER_NR                           VARCHAR(50)     COMMENT 'Descriptive Attribute - Optional business identifier of the hauler.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_DIM_HAULER PRIMARY KEY (PARTY_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED 
)  COMMENT = 'Major Dimension - Hauler (carrier) - responsible and executing party to move containers overseas. - Source - VMT';

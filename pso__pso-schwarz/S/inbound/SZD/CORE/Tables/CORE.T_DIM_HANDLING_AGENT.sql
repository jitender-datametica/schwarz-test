/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_HANDLING_AGENT
   generated from Powerdesigner on Montag, 22. April 2024 11:13:49
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_HANDLING_AGENT (
   PARTY_SID                           NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the handling agent ',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   HANDLING_AGENT_NAME                 VARCHAR(100)    NOT NULL COMMENT 'Natural Key/Business Key - The name of the handling agent ',
   SOURCE_HANDLING_AGENT_NAME_ADDRESS_CITY_TXT VARCHAR(1000)   NOT NULL COMMENT 'Descriptive Attribute - the name of the handling agent directly from source. Source: VMT',
   STATUS_CD                           VARCHAR(50)     NOT NULL COMMENT 'The status code for the company',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_DIM_HANDLING_AGENT PRIMARY KEY (PARTY_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED 
)  COMMENT = 'Major Dimension - Original handling agent - responsible for the tasks at the habor in Asia. - Source - VMT';

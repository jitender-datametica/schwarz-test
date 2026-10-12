/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_BOOKER
   generated from Powerdesigner on Dienstag, 8. August 2023 13:15:03
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_BOOKER (
   PARTY_SID                           NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the booker',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   BOOKER_NAME                         VARCHAR(100)    NOT NULL COMMENT 'Natural Key/Business Key - The name of the booker',
   SOURCE_BOOKER_NAME_ADDRESS_CITY_TXT VARCHAR(1000)   NOT NULL COMMENT 'Descriptive Attribute - the name of the booker directly from source. Source: VMT',
   STATUS_CD                           VARCHAR(50)     COMMENT 'The status code for the company',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_DIM_BOOKER PRIMARY KEY (PARTY_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED 
)  COMMENT = 'Major Dimension - A company which managing bookings of transportation for the lot. - Source - VMT';
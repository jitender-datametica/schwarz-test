/* --------------------------------------------------------------------------------
   DDL for table: T_VESSEL_2
   generated from Powerdesigner on Freitag, 2. August 2024 08:21:50
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_VESSEL_2 DATA_RETENTION_TIME_IN_DAYS = 7 (
   RESOURCE_ITEM_SID                   NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the vessel',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   VESSEL_STATUS_CD                    VARCHAR(50)     NOT NULL COMMENT 'The status_2 code for the vessel ',
   VESSEL_NR                           VARCHAR(50)     COMMENT 'Natural/Business Key  - Unique identifier for the vessel voyage in a source system',
   VESSEL_NAME                         VARCHAR(100)    COMMENT 'Descriptive Attribute -The name of the vessel',
   VOYAGE_NAME                         VARCHAR(100)    COMMENT 'Descriptive Attribute -Voyage numbers are used to identify shipments',
   LOOP_NAME                           VARCHAR(100)    COMMENT 'Descriptive Attribute - A loop is like a bus shedule for ships ',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_VESSEL PRIMARY KEY (RESOURCE_ITEM_SID, DWH_VALID_TO_TMSP) NOT ENFORCED 
)  COMMENT = 'Major Entity - A vessel transporing goods in particular voyage going by particular root. Source - VMT';

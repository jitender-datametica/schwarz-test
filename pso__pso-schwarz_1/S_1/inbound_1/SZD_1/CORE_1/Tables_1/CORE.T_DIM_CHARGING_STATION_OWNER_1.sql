/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_CHARGING_STATION_OWNER_1
   generated from Powerdesigner on Freitag, 9. Februar 2024 14:18:50
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_CHARGING_STATION_OWNER_1 (
   PARTY_SID                           NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the charging station owner.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   CHARGING_STATION_OWNER_NAME         VARCHAR(100)    NOT NULL COMMENT 'The displayable name of the charging station owner.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    NOT NULL COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_DIM_CHARGING_STATION_OWNER PRIMARY KEY (PARTY_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED 
)  COMMENT = 'Major Dimension - The charging station owner is a party that is responsible for one or more charging stations. - Source - IOT Charger';

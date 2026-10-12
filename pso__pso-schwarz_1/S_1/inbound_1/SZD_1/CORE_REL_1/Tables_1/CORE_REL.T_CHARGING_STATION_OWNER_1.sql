/* --------------------------------------------------------------------------------
   DDL for table: T_CHARGING_STATION_OWNER_1
   generated from Powerdesigner on Donnerstag, 8. Februar 2024 09:57:57
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_CHARGING_STATION_OWNER_1 (
   PARTY_SID                           NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the charging station owner.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   CHARGING_STATION_OWNER_NAME         VARCHAR(100)    NOT NULL COMMENT 'The name of the charging station owner.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_CHARGING_STATION_OWNER PRIMARY KEY (PARTY_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED 
)  COMMENT = 'Major Entity - The charging station owner is a party that is responsible for one or more charging stations. - Source - IOT Charger';

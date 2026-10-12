/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_CHARGER_1
   generated from Powerdesigner on Mittwoch, 17. Januar 2024 09:18:05
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_CHARGER_1 (
   RESOURCE_ITEM_SID                   NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the charger',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   CHARGER_PROVIDER_SYSTEM_CD          VARCHAR(50)     NOT NULL COMMENT 'Natural/Business Key - The unique code of the charger provider system.',
   CHARGING_STATION_OWNER_PARTY_SID    NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the charging station owner.',
   REAL_ESTATE_RESOURCE_ITEM_SID       NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the real estate.',
   CHARGER_STATION_TYPE_CD             VARCHAR(50)     NOT NULL COMMENT 'The unique code of the charger station type.',
   CHARGER_STATION_TYPE_NAME           VARCHAR(100)    NOT NULL COMMENT 'Descriptive Attribute - The name of the charger station type.',
   CHARGER_UUID_NR                     VARCHAR(250)    NOT NULL COMMENT 'Natural/Business Key - Technical key of the charger.',
   CHARGER_LABEL_NR                    VARCHAR(250)    NOT NULL COMMENT 'Descriptive Attribute - The label of the charger containing informations about the division and the associated real estate.',
   PUBLIC_DISPLAY_NAME                 VARCHAR(100)    COMMENT 'Descriptive Attribute -  The public display name of the charger.',
   LAST_HEARTBEAT_TMSP                 TIMESTAMP_TZ(9) COMMENT 'The timestamp of the last heartbeat of the charger.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_DIM_CHARGER PRIMARY KEY (RESOURCE_ITEM_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED 
)  COMMENT = 'Major Dimension - A charger (or charging station) is a device usually located at parking lots at stores or in parking garages where you can charge your electrical car. - Source - IOT Charger';

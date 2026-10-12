/* --------------------------------------------------------------------------------
   DDL for table: T_CHARGE_POINT_ERROR
   generated from Powerdesigner on Freitag, 17. November 2023 13:48:45
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_CHARGE_POINT_ERROR (
   ERROR_NR                            NUMBER(38, 0)   NOT NULL COMMENT 'The unique ID of the occured error.',
   CHARGER_PROVIDER_SYSTEM_CD          VARCHAR(50)     NOT NULL COMMENT 'The unique code of the charger provider system.',
   CHARGER_RESOURCE_ITEM_SID           NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the resource item.',
   CHARGE_POINT_RESOURCE_ITEM_SID      NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the charge point.',
   CHARGE_POINT_ERROR_DEFINITION_SID   NUMBER(38, 0)   NOT NULL COMMENT 'The unique surrogate key of the error definition.',
   CHARGING_STATION_OWNER_PARTY_SID    NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the charging station owner.',
   CREATED_AT_TMSP                     TIMESTAMP_TZ(9) NOT NULL COMMENT 'Technical timestamp when this record was created in the source.',
   OCCURANCE_DT                        DATE            NOT NULL COMMENT 'The date when the error has occured.',
   USER_REQUIRED_ON_SITE_FG            BOOLEAN         NOT NULL COMMENT 'Flag indicating whether the user was required to be in site.',
   TECHNICIAN_REQUIRED_ON_SITE_FG      BOOLEAN         NOT NULL COMMENT 'Flag indicating whether a technician was required to be in site.',
   MAINTENANCE_WINDOW_ACTIVE_FG        BOOLEAN         NOT NULL COMMENT 'Flag indicating whether the mainenance window was active.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_CHARGE_POINT_ERROR PRIMARY KEY (ERROR_NR) NOT ENFORCED 
)  COMMENT = 'Entity - Transactional - Transaction - Transactional fact capturing an event when an error is encountered at one of the chargepoints/charger. - Source - IOTCharger';

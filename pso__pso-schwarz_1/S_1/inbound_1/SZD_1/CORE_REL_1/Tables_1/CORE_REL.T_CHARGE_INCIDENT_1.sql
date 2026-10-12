/* --------------------------------------------------------------------------------
   DDL for table: T_CHARGE_INCIDENT_1
   generated from Powerdesigner on Freitag, 17. November 2023 10:01:11
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_CHARGE_INCIDENT_1 (
   AGREEMENT_SID                       NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the event.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   CHARGER_PROVIDER_SYSTEM_CD          VARCHAR(50)     NOT NULL COMMENT 'The unique code of the charger provider system.',
   CHARGER_RESOURCE_ITEM_SID           NUMBER(38, 0)   COMMENT 'The unique identifier (surrogate key) for the resource item.',
   CHARGE_POINT_RESOURCE_ITEM_SID      NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the charge point.',
   CHARGE_INCIDENT_TYPE_ID             NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the charge incident type.',
   INCIDENT_ID                         NUMBER(38, 0)   NOT NULL COMMENT 'Technical key of the incident.',
   INCIDENT_NAME                       VARCHAR(1000)   COMMENT 'The name of the incident.',
   INCIDENT_DESCR                      VARCHAR(10000)  COMMENT 'A brief description of the incident given by the caller.',
   INCIDENT_DT                         DATE            NOT NULL COMMENT 'The date when the incident was filed.',
   CREATED_TMSP                        TIMESTAMP_TZ(9) NOT NULL COMMENT 'Technical timestamp when this record was created in the source',
   TOTAL_EDIT_DURATION_SEC             NUMBER(38,0)    NOT NULL COMMENT 'Total time needed for the processing in seconds.',
   ESCALATED_FG                        BOOLEAN         NOT NULL COMMENT 'Flag indicating whether the incident was escalated.',
   CAR_BRAND_NAME                      VARCHAR(100)    COMMENT 'Descriptive Attribute - The name of the car brand.',
   CLIENT_NAME                         VARCHAR(100)    NOT NULL COMMENT 'The name of the client.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_CHARGE_INCIDENT PRIMARY KEY (AGREEMENT_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED 
)  COMMENT = 'Major Entity- Contains the incidents reported by users of a charging station when any kind of problem has occurred while charging the car. - Source - IOTCharger';

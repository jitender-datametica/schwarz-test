/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_CHARGER_REPORT_SNAPSHOT_PER_MONTH_1
   generated from Powerdesigner on Mittwoch, 9. Juli 2025 09:56:33
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_CHARGER_REPORT_SNAPSHOT_PER_MONTH_1 (
   REPORT_MONTH                        NUMBER(38, 0)   NOT NULL COMMENT 'The calendar_1 month as a number of the form YYYYMM, where YYYY is the calendar_1 year and MM_1 is month of the calendar_1 year.',
   CHARGER_PROVIDER_SYSTEM_CD          VARCHAR(50)     NOT NULL COMMENT 'The unique code of the charger provider system.',
   CHARGING_STATION_OWNER_PARTY_SID    NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the charging station owner.',
   REAL_ESTATE_RESOURCE_ITEM_SID       NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the real estate.',
   COUNTRY_LOCATION_SID                NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) of the political country.',
   DIVISION_PARTY_SID                  NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the party as a division. Key generation based on META table for party key space.',
   CHARGER_STATION_TYPE_CD             VARCHAR(50)     NOT NULL COMMENT 'The unique code of the charger station type.',
   CHARGER_CLASSIFICATION_ID           NUMBER(38, 0)   NOT NULL COMMENT 'Unique identifier of the classification of a charger.',
   AVAILABLE_CHARGER_CNT               NUMBER(38,0)    NOT NULL COMMENT 'Fact - semi additive - Count of available chargers.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',   
   CONSTRAINT PK_FACT_CHARGER_REPORT_SNAPSHOT_PER_MONTH PRIMARY KEY (REPORT_MONTH, CHARGER_PROVIDER_SYSTEM_CD, COUNTRY_LOCATION_SID, CHARGER_STATION_TYPE_CD, CHARGING_STATION_OWNER_PARTY_SID, REAL_ESTATE_RESOURCE_ITEM_SID, DIVISION_PARTY_SID, CHARGER_CLASSIFICATION_ID) NOT ENFORCED 
)  COMMENT = 'Fact table - Snapshot_1 - Granularity - by month, charging provider system, country_1, charging station type and plugin type. - Aggregate - Contains snapshot_1 facts for the "Charger Report". - Source - IOT Charger';

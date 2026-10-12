/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_CHARGER_SNAPSHOT_PER_DAY_2
   generated from Powerdesigner on Mittwoch, 9. Juli 2025 13:57:53
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_CHARGER_SNAPSHOT_PER_DAY_2 (
   REPORT_DT                           DATE            NOT NULL COMMENT 'The day represented as a calendar_2 date of the form YYYY-MM_2-DD. YYYY is the calendar_2 year, MM_2 (between 1 and 12) the calendar_2 month and DD the day of the calendar_2 month (between 1 and 31). ',
   CHARGER_PROVIDER_SYSTEM_CD          VARCHAR(50)     NOT NULL COMMENT 'The unique code of the charger provider system.',
   CHARGER_RESOURCE_ITEM_SID           NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the charge point.',
   CHARGING_STATION_OWNER_PARTY_SID    NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the charging station owner.',
   REAL_ESTATE_RESOURCE_ITEM_SID       NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the real estate.',
   COUNTRY_LOCATION_SID                NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) of the political country.',
   DIVISION_PARTY_SID                  NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the party as a division. Key generation based on META table for party key space.',
   CHARGER_STATION_TYPE_CD             VARCHAR(50)     NOT NULL COMMENT 'The unique code of the charger station type.',
   CHARGER_CLASSIFICATION_ID           NUMBER(38, 0)   NOT NULL COMMENT 'Unique identifier of the classification of a charger.',
   AVAILABLE_CHARGER_CNT               NUMBER(38,0)    NOT NULL COMMENT 'Fact - semi additive - Count of available charging stations (per day).',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',   
   CONSTRAINT PK_FACT_CHARGER_SNAPSHOT_PER_DAY PRIMARY KEY (REPORT_DT, CHARGER_PROVIDER_SYSTEM_CD, CHARGER_RESOURCE_ITEM_SID, CHARGING_STATION_OWNER_PARTY_SID, REAL_ESTATE_RESOURCE_ITEM_SID, COUNTRY_LOCATION_SID, DIVISION_PARTY_SID, CHARGER_STATION_TYPE_CD, CHARGER_CLASSIFICATION_ID) NOT ENFORCED 
)  COMMENT = 'Fact table - Snapshot_2 - Granularity - by day and charging station. - Aggregate - Contains snapshot_2 facts regarding a charger. - Source - IOT Charger';

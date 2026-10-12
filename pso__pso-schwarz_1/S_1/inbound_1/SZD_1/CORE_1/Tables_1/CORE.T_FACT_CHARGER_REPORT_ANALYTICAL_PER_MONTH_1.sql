/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_CHARGER_REPORT_ANALYTICAL_PER_MONTH_1
   generated from Powerdesigner on Dienstag, 9. September 2025 11:34:46
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_CHARGER_REPORT_ANALYTICAL_PER_MONTH_1 (
   REPORT_MONTH                        NUMBER(38, 0)   NOT NULL COMMENT 'The calendar_1 month as a number of the form YYYYMM, where YYYY is the calendar_1 year and MM_1 is month of the calendar_1 year.',
   CHARGER_PROVIDER_SYSTEM_CD          VARCHAR(50)     NOT NULL COMMENT 'The unique code of the charger provider system.',
   CHARGING_STATION_OWNER_PARTY_SID    NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the charging station owner.',
   REAL_ESTATE_RESOURCE_ITEM_SID       NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the real estate.',
   COUNTRY_LOCATION_SID                NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) of the political country.',
   DIVISION_PARTY_SID                  NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the party as a division. Key generation based on META table for party key space.',
   CHARGER_STATION_TYPE_CD             VARCHAR(50)     NOT NULL COMMENT 'The unique code of the charging power type.',
   AUTHENTICATION_METHOD_CD            VARCHAR(50)     NOT NULL COMMENT 'The unique code of the authentication method.',
   CHARGER_CLASSIFICATION_ID           NUMBER(38, 0)   NOT NULL COMMENT 'Unique identifier of the classification of a charger.',
   CURR_CD                             VARCHAR(3)      NOT NULL COMMENT 'The EUR currency code.',
   LOCAL_CURR_CD                       VARCHAR(3)      NOT NULL COMMENT 'The code of the local currency.',
   RELEVANCE_FG                        BOOLEAN         NOT NULL COMMENT 'A flag indicating this log entry is relevant to be considered in reporting.',
   PROVIDED_POWER_MEAS                 NUMBER(38, 5)   NOT NULL COMMENT 'Fact - additive - The sum of the provided/sold power (energy) by the charge point measured in kWh.',
   CHARGING_PROCESS_CNT                NUMBER(38,0)    NOT NULL COMMENT 'Fact - additive - The count of charging processes by the charge point.',
   CHARGING_DURATION_SEC_MEAS          NUMBER(38,0)    NOT NULL COMMENT 'Fact - additive - The sum of seconds of all charging processes.',
   CHARGING_PERFORMANCE_MEAS           NUMBER(38, 5)   NOT NULL COMMENT 'Fact - additive - The charging performance of the charging processes  measured in kWh.',
   TURNOVER_EUR_VAL                    NUMBER(38, 5)   NOT NULL COMMENT 'Fact - additive - The sum of the turnover amount of the charge point in EUR.',
   TURNOVER_LOCAL_VAL                  NUMBER(38, 5)   NOT NULL COMMENT 'Fact - additive - The sum of the turnover amount of the charge point in the local currency.',
   CUSTOMER_CNT                        NUMBER(38,0)    NOT NULL COMMENT 'Fact - semi additive - The count of different customers.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',   
   CONSTRAINT PK_FACT_CHARGER_REPORT_ANALYTICAL_PER_MONTH PRIMARY KEY (REPORT_MONTH, CHARGER_PROVIDER_SYSTEM_CD, COUNTRY_LOCATION_SID, REAL_ESTATE_RESOURCE_ITEM_SID, DIVISION_PARTY_SID, AUTHENTICATION_METHOD_CD, CHARGER_STATION_TYPE_CD, CHARGING_STATION_OWNER_PARTY_SID, CHARGER_CLASSIFICATION_ID) NOT ENFORCED 
)  COMMENT = 'Fact table - Analytical - Granularity - by month, charging provider system, country_1, charging station type and plugin type. - Aggregate - Contains aggregatable facts for the "Charger Report". - Source - IOT Charger';

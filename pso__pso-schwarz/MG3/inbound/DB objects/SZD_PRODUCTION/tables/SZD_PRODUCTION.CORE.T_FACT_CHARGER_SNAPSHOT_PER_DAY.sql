create or replace TABLE SZD_PRODUCTION.CORE.T_FACT_CHARGER_SNAPSHOT_PER_DAY (
	REPORT_DT DATE NOT NULL COMMENT 'The day represented as a calendar date of the form YYYY-MM-DD. YYYY is the calendar year, MM (between 1 and 12) the calendar month and DD the day of the calendar month (between 1 and 31). ',
	CHARGER_PROVIDER_SYSTEM_CD VARCHAR(50) NOT NULL COMMENT 'The unique code of the charger provider system.',
	CHARGER_RESOURCE_ITEM_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the charge point.',
	CHARGING_STATION_OWNER_PARTY_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the charging station owner.',
	REAL_ESTATE_RESOURCE_ITEM_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the real estate.',
	COUNTRY_LOCATION_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) of the political country.',
	DIVISION_PARTY_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the party as a division. Key generation based on META table for party key space.',
	CHARGER_STATION_TYPE_CD VARCHAR(50) NOT NULL COMMENT 'The unique code of the charger station type.',
	CHARGER_CLASSIFICATION_ID NUMBER(38,0) NOT NULL COMMENT 'Unique identifier of the classification of a charger.',
	AVAILABLE_CHARGER_CNT NUMBER(38,0) NOT NULL COMMENT 'Fact - semi additive - Count of available charging stations (per day).',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	constraint PK_FACT_CHARGER_SNAPSHOT_PER_DAY primary key (REPORT_DT, CHARGER_PROVIDER_SYSTEM_CD, CHARGER_RESOURCE_ITEM_SID, CHARGING_STATION_OWNER_PARTY_SID, REAL_ESTATE_RESOURCE_ITEM_SID, COUNTRY_LOCATION_SID, DIVISION_PARTY_SID, CHARGER_STATION_TYPE_CD, CHARGER_CLASSIFICATION_ID)
)COMMENT='Fact table - Snapshot - Granularity - by day and charging station. - Aggregate - Contains snapshot facts regarding a charger. - Source - IOT Charger'
;
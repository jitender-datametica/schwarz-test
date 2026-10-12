create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_GEOGRAPHICAL_AREA_HOLIDAY_1 (
	CAL_DT DATE NOT NULL COMMENT 'The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31). ',
	GEO_AREA_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the geographical area.',
	GEO_AREA_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the discriminator for geographical areas.',
	HOLIDAY_CD VARCHAR(100) NOT NULL COMMENT 'The code identifying the type of holiday. E.g. Christmas, Easter Sunday, ...',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	HOLIDAY_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the type of a holiday. E.g. public holiday or regional holiday.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_GEOGRAPHICAL_AREA_HOLIDAY primary key (CAL_DT, HOLIDAY_CD, GEO_AREA_SID, DWH_VALID_FROM_TMSP)
)COMMENT='A relationship containing the holidays that exist for a certain geographical area. This may be on country_1 level, for a territory or even down to city level. Depending on the location_1, a holiday may be of a different type. E.g. in Catholic regions of Germany August 15th is a public holiday, whereas in Protestant regions it is only a non-recognized holiday.'
;
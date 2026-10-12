create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_PLAN_BY_DAY_1 (
	INT_ORG_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the internal organization.',
	INT_ORG_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the discriminators for internal organizations.',
	REAL_ESTATE_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the real estate object.',
	CAL_DT DATE NOT NULL COMMENT 'The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31). ',
	PLANNED_VAL_TYPE_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the kind of value for which a plan is made. E.g. a forecast for revenue or customer count.',
	PLAN_POS_NR VARCHAR(20) NOT NULL COMMENT 'The planning position is identified in the operational planning system by a number. As several positions may be planned for the same Planned Value Type, this attribute is part of the key. In particular, the planning position number is used for plan values for stores, which have not been opened yet. A dummy_1 number is assigned for these stores, and the planned value is related to the related internal company. (Once the real store number is known, the plan value for the internal company is expired in history, and a new plan value is added for the store.)',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	PLANNED_KPI_MEAS NUMBER(38,5) NOT NULL COMMENT 'The planned value.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_PLAN_BY_DAY_TMP primary key (PLANNED_VAL_TYPE_SID, REAL_ESTATE_SID, CAL_DT, INT_ORG_SID, PLAN_POS_NR, DWH_VALID_FROM_TMSP)
)COMMENT='Certain KPIs (such as revenue or customer count) get planned ahead of time. This entity tracks values which are planned on daily level. The kind of KPI is defined by the Planned Value Type Code.'
;
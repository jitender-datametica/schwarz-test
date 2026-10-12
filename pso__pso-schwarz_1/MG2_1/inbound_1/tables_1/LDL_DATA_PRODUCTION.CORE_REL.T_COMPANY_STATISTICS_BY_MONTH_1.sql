create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_COMPANY_STATISTICS_BY_MONTH_1 (
	INT_COMPANY_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the internal company, for which statistics have been calculated.',
	STAT_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the kind of metric which is calculated for internal companies.',
	STAT_DT DATE NOT NULL COMMENT 'The date when the statistics were collected. ',
	CAL_MONTH NUMBER(38,0) NOT NULL COMMENT 'The identifier of a calendar_1 month in the form YYYYMM. E.g. 202101 für January 2021.',
	CURR_STAT_FG BOOLEAN NOT NULL COMMENT 'An indicator showing, if this is the current record for the given key, i.e. the record with the latest statistics date. Filtering on this flag returns the statistics after any corrections.',
	STAT_VAL NUMBER(38,5) COMMENT 'The calculated statistics amount for the given month, statistics type and internal company. (Depending on the statistics type this may be a net or a gross value.)',
	CURR_CD VARCHAR(3) COMMENT 'The code identifying the currency, according to ISO 4217.',
	STAT_CNT NUMBER(38,0) COMMENT 'The calculated statistics count for the given month, statistics type and internal company.',
	STAT_QTY NUMBER(38,5) COMMENT 'The calculated statistics quantity for the given month, statistics type and internal company.',
	STAT_MEAS NUMBER(38,5) COMMENT 'The calculated statistics measure for the given month, statistics type and internal company.',
	UOM_CD VARCHAR(20) COMMENT 'The code identifying the unit_1 of measure for the statistics measure.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_COMPANY_STATISTICS_BY_MONTH primary key (STAT_DT, INT_COMPANY_SID, CAL_MONTH, STAT_TYPE_CD)
) WITH ROW ACCESS POLICY #unknown_policy
COMMENT='Various derived metrics can be calculated on the level of a month and an internal company. These values are not necessarily in sync with the underlying base events. The table contains separate columns for each domain of statistics values. Depending on the statistics type, one of them is filled.'
;
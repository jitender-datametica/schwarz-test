create or replace TABLE SZD_PRODUCTION.ETL.T_CACHE_LOT_2 (
	LOT_NR VARCHAR(50),
	BOOKED_TEU NUMBER(38,10),
	NOMINATED_TEU NUMBER(38,10),
	BOOKED_TOTAL_CARTONS NUMBER(38,10),
	NOMINATED_TOTAL_CARTONS NUMBER(38,10),
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was created or last updated.',
	DWH_SRC_FILE_NAME VARCHAR(500) COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	DWH_SRC_1_TMSP TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
	VALID_FROM TIMESTAMP_LTZ(9),
	SHIPPED_TEU NUMBER(38,10)
);
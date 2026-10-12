CREATE TABLE CORE.T_FACT_SHOP_CATEGORY_RESPONSIBLE_2 (
	PROD_BRICK_CD VARCHAR(40) NOT NULL COMMENT 'The Brickcode is a unique standardized code of all categories in the GS1 article categorization system on level 4 and is maintained for every article in SAP. ',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record in history.',
	RESP_TEAM_NAME VARCHAR(100) COMMENT 'LDI''s responsible category team.',
	CAT_MANAGER_NAME VARCHAR(100) COMMENT 'Name of the responsible online category manager',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME VARCHAR(255) NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	SRC_FILE_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
	SRC_TABLE_NAME VARCHAR(100) COMMENT 'The name of the source tables',
	CONSTRAINT PK_T_FACT_SHOP_CATEGORY_RESPONSIBLE PRIMARY KEY (PROD_BRICK_CD, DWH_VALID_FROM_TMSP)
)COMMENT='A list of  employees who is responsible for shop categories'
;
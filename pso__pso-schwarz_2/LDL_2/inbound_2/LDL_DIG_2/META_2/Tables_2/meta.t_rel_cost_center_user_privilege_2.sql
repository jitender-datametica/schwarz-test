CREATE TABLE META.T_REL_COST_CENTER_USER_PRIVILEGE_2 
	(
	USERNAME						VARCHAR(50)					COMMENT 	'Username of the user (Lidl Digital employee_2)',
	FULL_MSTR_LOGIN_NAME			VARCHAR(100) 	NOT NULL 	COMMENT		'Microstrategy login of the user (Lidl Digital employee_2)',
	FISCAL_YEAR					NUMBER(38,0) 	NOT NULL	COMMENT 	'A number that represents the fiscal year of the hierarchy_2',
	COST_CENTER_NR					VARCHAR(20)		NOT NULL	COMMENT 	'Identifier of the Cost Center',
    DWH_CREATED_TMSP				TIMESTAMP,
	DWH_UPDATED_TMSP				TIMESTAMP,
	DWH_SRC_FILE_NAME				VARCHAR,
	SRC_FILE_TMSP					TIMESTAMP,
CONSTRAINT PK_T_REL_COST_CENTER_USER_PRIVILEGE PRIMARY KEY (FULL_MSTR_LOGIN_NAME, FISCAL_YEAR, COST_CENTER_NR)
	)
COMMENT = 'This table contains users information and all the cost centers they have privileges for'
	;
CREATE TABLE META.T_REPORT_WEBSHOP_USER_PRIVILEGE_1
	(
    REPORT_NAME                     VARCHAR(50)                 COMMENT 'Name of the report for which this condition is used',
	USERNAME						VARCHAR(50)		            COMMENT 	'Username of the user (Lidl Digital employee_1)',
	FULL_MSTR_LOGIN_NAME			VARCHAR(100) 	NOT NULL 	COMMENT		'Microstrategy login of the user (Lidl Digital employee_1)',
	WSHOP_CD	        			VARCHAR(20)		NOT NULL	COMMENT 	'The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country_1 and is run by an Lidl Digital Country_1',
    TMSP_INSERT				        TIMESTAMP,
	TMSP_UPDATE				        TIMESTAMP,
CONSTRAINT PK_T_REL_WEBSHOP_USER_PRIVILEGE PRIMARY KEY (FULL_MSTR_LOGIN_NAME, WSHOP_CD)
	)
COMMENT = 'This table contains users information and all the webshops they have privileges for in the specified report'
	;
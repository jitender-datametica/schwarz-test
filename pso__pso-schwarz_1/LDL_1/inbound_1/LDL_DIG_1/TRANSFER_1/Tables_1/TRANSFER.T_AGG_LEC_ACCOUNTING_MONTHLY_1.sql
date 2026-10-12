CREATE TABLE TRANSFER.T_AGG_LEC_ACCOUNTING_MONTHLY_1 (
	BUS_YEAR						NUMBER(38,0)		NOT NULL	COMMENT 'The business year (starting in March, ending in February of the following calendar_1 year)',
	MONTH_OF_BUS_YEAR				NUMBER(38,0)		NOT NULL	COMMENT 'The month of business year, indicated by a number (1 = March, 2 = April, ... 12 = February)',
	CC_GROUP_LVL4_NR				VARCHAR(20)			NOT NULL	COMMENT 'Identifier of the level 4 Cost Center Group',
	CC_GROUP_LVL4_NAME				VARCHAR(100)					COMMENT 'Name of the level 4 Cost Center Group',
	PROFIT_LOSS_POSITION_NR			VARCHAR(20)			NOT NULL	COMMENT 'Identifier of the Profit/Loss position (KER Position) according to the associated fiscal year hierarchy_1',
	PROFIT_LOSS_POSITION_NAME		VARCHAR(100)		NOT NULL	COMMENT 'Description of the profit/loss accounting position',
	PROFIT_LOSS_POSITION_EUR_VALUE 	NUMBER(38,5)					COMMENT 'Accounting position value, in group currency (EUR)',
	DWH_CREATED_TMSP 				TIMESTAMP_LTZ(9)   	NOT NULL    COMMENT 'The point in time when this record was created in the data warehouse',
	DWH_UPDATED_TMSP 				TIMESTAMP_LTZ(9)   	NOT NULL    COMMENT 'The point in time when this record was last updated',
	DWH_SRC_FILE_NAME 				VARCHAR(255)       	NOT NULL    COMMENT 'The path and the name of the file(s) from which this record was loaded',
	CONSTRAINT PK_T_AGG_LEC_ACCOUNTING_MONTHLY PRIMARY KEY ( BUS_YEAR, MONTH_OF_BUS_YEAR, CC_GROUP_LVL4_NR, PROFIT_LOSS_POSITION_NAME )
) COMMENT = 'This table is used for the monthly reporting of aggregated accounting KPIs for Lidl E-Commerce'
;
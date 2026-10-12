/*
#-------------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG
#-------------------------------------------------------------------------------
# Interface : DDL for T_AGG_STORE_WH_DAY_EJR_1
#-------------------------------------------------------------------------------
# Description:  This table provides aggregated Umsatz, Umsatz for Food and 
#				NonFood and Bon Totals for current and previous year.
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2023-04-03 Prasanna Ranjan	 Initial Version
#-------------------------------------------------------------------------------
*/

CREATE TABLE P_LEW_MART_LEAD.T_AGG_STORE_WH_DAY_EJR_1 CLUSTER BY (CLIENT_ID, CY_WEEK)(
	CLIENT_ID									INTEGER			NOT NULL	DEFAULT -1 										COMMENT 'Client ID e.g AT=1',
	CURRENCY_ISO_CD								VARCHAR(3) 		NOT NULL													COMMENT 'Currency ISO Code = WAWI Country_1 ',
	WH_ID										INTEGER			NOT NULL	DEFAULT -1 										COMMENT 'Warehouse ID',
	MOVE_TO_STORE_ID							INTEGER			NOT NULL	DEFAULT -1 										COMMENT 'Unique key Region_1 surrogate key',
	CY_WEEK										INTEGER			NOT NULL	DEFAULT 888853 									COMMENT 'Number of week, YYYYWW',
	PREVIOUS_YEAR_FG							NUMBER(38,0)	NOT NULL	DEFAULT -1 										COMMENT 'Flag indicating if current year 0 or previous year 1',
	LAST_12_CY_WEEK_FG							NUMBER(38,0)	NOT NULL	DEFAULT -1                                      COMMENT	'Flag indicating if in last 12 weeks',
	VAL_RETURN_NET_EJR_ASIS						NUMBER(38,5) 																COMMENT 'Returns value',
	VAL_RTL_NET_EJR_ASIS						NUMBER(38,5) 																COMMENT 'Umsatz EJR',
	VAL_RETURN_NET_EJR_ASIS_NF					NUMBER(38,5) 																COMMENT 'Returns value for NonFood',
	VAL_RTL_NET_EJR_ASIS_NF						NUMBER(38,5) 																COMMENT 'Umsatz EJR for NonFood',
	VAL_RETURN_NET_EJR_ASIS_FA					NUMBER(38,5) 																COMMENT 'Returns value for Food Aktion_1',
	VAL_RTL_NET_EJR_ASIS_FA						NUMBER(38,5) 																COMMENT 'Umsatz EJR for Food Aktion_1',
    -- Technical fields
	DWH_CREATED_TS								TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP() 					COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS								TIMESTAMP		 															COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID										INTEGER			NOT NULL	DEFAULT 0 										COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (CLIENT_ID, CURRENCY_ISO_CD, WH_ID, MOVE_TO_STORE_ID, CY_WEEK, PREVIOUS_YEAR_FG)
)	COMMENT='Basis fact table on Store Week'
;
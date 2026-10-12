/*
#-------------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG
#-------------------------------------------------------------------------------
# Interface : DDL for T_AGG_STORE_HOUR_SALES_CNT_BGES
#-------------------------------------------------------------------------------
# Description:  This table provides aggregated Bon Totals and Umsatz with 
#               the granularity of client/store/day/hour.
#               The aspect_id is fixed to 1 (BGES)
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2023-04-03 Prasanna Ranjan	 Initial Version
#-------------------------------------------------------------------------------
*/

CREATE TABLE P_LEW_MART_LEAD.T_AGG_STORE_HOUR_SALES_CNT_BGES CLUSTER BY (CLIENT_ID, DAT_FORMDATE)(
	CLIENT_ID									INTEGER			NOT NULL	DEFAULT -1 										COMMENT 'Client ID e.g AT=1',
	MOVE_TO_STORE_ID							INTEGER			NOT NULL	DEFAULT -1 										COMMENT 'Unique key Region surrogate key',
	DAT_FORMDATE								DATE			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM-DD') 	COMMENT 'Reference date',
	TIME_HOUR_ID								INTEGER			NOT NULL 	DEFAULT -1								        COMMENT 'Hour ID: 01 - 24',
	LAST_12_CY_WEEK_FG							NUMBER(38,0)	NOT NULL	DEFAULT -1                                      COMMENT	'Flag indicating if in last 12 weeks',
	CNT_CUSTOMER_ASIS						    NUMBER(38,0)		 		DEFAULT 0										COMMENT 'Number of receipts',
    -- Technical fields
	DWH_CREATED_TS								TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP() 					COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS								TIMESTAMP		 															COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID										INTEGER			NOT NULL	DEFAULT 0 										COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (CLIENT_ID, MOVE_TO_STORE_ID, DAT_FORMDATE, TIME_HOUR_ID)
)	COMMENT='Table for number of receipts and Umsatz EJR with half-hourly granularity'
;
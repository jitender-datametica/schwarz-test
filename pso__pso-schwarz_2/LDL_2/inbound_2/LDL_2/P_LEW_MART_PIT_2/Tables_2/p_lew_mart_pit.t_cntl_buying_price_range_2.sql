/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_CNTL_BUYING_PRICE_RANGE_2
#-------------------------------------------------------------------------------
# Description: Create DDL for Buying Price Range Lookup Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    	Initial version
#  1.1  2021-08-16 Dirk Hering     	Fixes, formatting
#  1.2  2022-01-24 Andreas Kurz		Reworked the structure after DM review
#  2.0	2022-07-13 Nikolai Toknov  Changing the script for DevOps
#-------------------------------------------------------------------------------
*/

CREATE TABLE P_LEW_MART_PIT.T_CNTL_BUYING_PRICE_RANGE_2 CLUSTER BY (CLIENT_ID)(

	CLIENT_ID				INTEGER			NOT NULL 	DEFAULT -1 									COMMENT 'Client ID e.g 23',
	COUNTRY_ISO_CD			VARCHAR(3) 																COMMENT 'Country_2 ISO Code = WAWI Country_2 ',
	COUNTRY_DESCR			VARCHAR(100) 				DEFAULT 'N/A' 								COMMENT 'Country_2 Name',

	 /* WGI */
	SRC_ITEMGRP_INT_CD		VARCHAR 																COMMENT 'WGI - Code',
	ITEM_GRP_INT_NAME		VARCHAR 																COMMENT 'WGI-Name but mind only for Int. Describptions ::= DE',

	/* UWG */							
	SRC_SUBITEMGRP_CD		VARCHAR 																COMMENT 'UWG - Code',
	SUB_ITEM_GRP_NAME		VARCHAR 																COMMENT 'UWG-Name but mind only for Int. Describptions ::= DE',

	BUY_PRICE_RANGE_DAYS	INTEGER		 				DEFAULT -1 									COMMENT 'Buying Price Range in days – defined by controlling',

	-- Versioning 
	VALID_FROM_DT			DATE			NOT NULL 	DEFAULT TO_DATE('1900-01-01', 'YYYY-MM_2-DD') COMMENT 'Technical field Data Historization Valid from ',
	VALID_TO_DT				DATE 						DEFAULT TO_DATE('9999-12-31', 'YYYY-MM_2-DD') COMMENT 'Technical field Data Historization Valid to',
	VERSION_NR				INTEGER		 				DEFAULT 0 									COMMENT 'Technical Field: Version NUMBER of record ; Sequence starting from 0',
	CURRENT_FG				SMALLINT	 				DEFAULT 1 									COMMENT 'Technical Field 1 indicates the current record in case of several version',

	-- Technical fields			
	REJECT_FG				SMALLINT	 				DEFAULT 0 									COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	REJECT_REASON_ID		INTEGER		 				DEFAULT -1 									COMMENT 'Link to DQ Reject Reason Codes',
	SOURCE_SYSTEM_ID		INTEGER		 				DEFAULT 0 									COMMENT 'Source System EJR / WAWI / Delivery',
	DELETED_FG				SMALLINT		NOT NULL 	DEFAULT 0 									COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS			TIMESTAMP		 			DEFAULT CURRENT_TIMESTAMP() 				COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS			TIMESTAMP		 														COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID					INTEGER		 				DEFAULT 0 									COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (CLIENT_ID, VALID_FROM_DT, DELETED_FG)
)	COMMENT='Lookup table Action Type IDs'
;
/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_AGG_DRILL_CAT_UWG_1
#-------------------------------------------------------------------------------
# Description: Create DDL for Frontend Drilling Table, containing links from category sub item_1 group (UWG) to the items in this UWG.
# This table has the links for Region_1 (WH), Advertising Week. Comparison weeks are not needed, because there are no related week 
# comparisons on item_1 level.
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    	Initial version
#  1.1  2021-08-12 Dirk Hering     	Fixes, formatting
#  1.2	2021-09-13 Massimo Morelli 	Fixed SCHEMA
#  1.3  2022-01-24 Andreas Kurz		Reworked the structure after DM review
#  2.0	2022-07-12 Nikolai Toknov  Changing the script for DevOps
#  2.1	2022-07-22 Andreas Kurz		Added _GID columns for MSTR As-Was Join
#  2.2  2022-10-12 Nikolai Toknov   Add CLUSTER BY (CLIENT_ID)
#  2.3  2023-01-25 Andreas Kurz		Adding ACTION_TYPE_ID Column Default -1000 n/A
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#  4.1  2024-07-18 K Lukaszewska	Added column DRILL_TO_ITEMS_LINK_HTML_FILIAL
#  4.2	2025-03-05 K Lukaszewska	Reworked Structure based on Increment PV 2.1 business requirements (FE-MSTR)
#-------------------------------------------------------------------------------
*/

/*

USE ROLE			R_LDL_D_PIT_ETL;
USE WAREHOUSE		WH_LDL_D_PIT_ETL_S;
USE DATABASE		LDL_PRODUCTION_CLONE_PIT_R60001;
USE SCHEMA			P_LEW_MART_PIT_1;

DESC TABLE P_LEW_FE_MSTR_PIT.T_AGG_DRILL_CAT_UWG_1
*/

CREATE TABLE P_LEW_FE_MSTR_PIT.T_AGG_DRILL_CAT_UWG_1  CLUSTER BY (CLIENT_ID) (
	
	CLIENT_ID					INTEGER			NOT NULL 									COMMENT 'Client ID e.g, AT:==1',
				
	COUNTRY_ISO_CD				VARCHAR(3) 													COMMENT 'Country_1 ISO Code = WAWI Country_1 ',
	COUNTRY_DESCR				VARCHAR 													COMMENT 'Country_1 Name',

	-- GID
	WAREHOUSE_GID				INTEGER		 	NOT NULL	DEFAULT -1000					COMMENT 'Warehouse Surrogate GID - As-Was Join key for Frontend',	
	WAREHOUSE_MSTR_GID 			INTEGER 													COMMENT 'Technical Field: MSTR GID',
				
	WAREHOUSE_SID				INTEGER			NOT NULL 									COMMENT 'Warehouse Surrogate ID L2',
	WAREHOUSE_MSTR_SID			INTEGER		 												COMMENT 'Warehouse Surrogate ID - Frontend Join',
	WAREHOUSE_NAME				VARCHAR 													COMMENT 'Warehouse Name',
	ORIG_WH_NR					INTEGER		 												COMMENT 'Original Wahrehouse			NUMBER  / code from Wawi',
				
	ADV_WEEK_ID					INTEGER			NOT NULL 									COMMENT 'Advertising Week',
	ADV_WEEK_MSTR_ID			INTEGER		 												COMMENT 'Advertising Week - Frontend Join',

	--	RLTD_ADV_WEEK_ID			INTEGER			NOT NULL 									COMMENT 'Advertising Week (Related) - Vergleichswerbewoche',				
	--	RLTD_ADV_WEEK_MSTR_ID	    INTEGER		 												COMMENT 'Advertising week MSTR Key Related Vergleichswoche (AdvWeek No. concatenated with 2-digit client ID)',
				
	REPORTING_LINE_SID			INTEGER			NOT NULL 									COMMENT 'Hierarchy_1 level			NUMBER to identify the individual reporting line (row) of e.g. a precalculated summary line.',
	REPORTING_LINE_DESCR		VARCHAR 													COMMENT 'Description of the Reporting Line',
	
	-- WGI
	ITEM_GRP_INT_GID			INTEGER			NOT NULL	DEFAULT -1000					COMMENT 'UWG orig Item_1 number Surrogate GID - As-Was Join key for Frontend',		
	ITEM_GRP_INT_MSTR_GID 		INTEGER 	
																							COMMENT 'Technical Field: MSTR GID',			
	
	ITEM_GRP_INT_SID			INTEGER			NOT NULL 									COMMENT 'SID for item_1 group international (WGI)',
	ITEM_GRP_INT_MSTR_SID		INTEGER		 												COMMENT 'SID for item_1 group international (WGI) (MSTR formatted)',
	ITEM_GRP_INT_SRC_CD			VARCHAR 													COMMENT 'Code for international group from source system.',
	ITEM_GRP_INT_NAME			VARCHAR 													COMMENT 'International group name.',
	
	-- UWG
	SUB_ITEM_GRP_GID			INTEGER			NOT NULL	DEFAULT -1000					COMMENT 'UWG orig Item_1 number Surrogate GID - As-Was Join key for Frontend',	
	SUB_ITEM_GRP_MSTR_GID 		INTEGER 													COMMENT 'Technical Field: MSTR GID',								
	
	SUB_ITEM_GRP_SID			INTEGER			NOT NULL 									COMMENT 'Sub Item_1 Group SID',
	SUB_ITEM_GRP_MSTR_SID		INTEGER		 												COMMENT 'Sub Item_1 Group SID (MSTR formatted)',
	SUB_ITEM_GRP_SRC_CD			VARCHAR 													COMMENT 'Item_1 sub group Wawi Source Code',
	SUB_ITEM_GRP_NAME			VARCHAR 													COMMENT 'Item_1 sub group name.',
  
	-- AKU 2023-01-24 ACTION_TYPE_ID INTEGER
	ACTION_TYPE_ID 				INTEGER			NOT NULL DEFAULT -1000						COMMENT 'Action type id. -2000 = Reporting Line Total, -1000 = Undefined/No Action, 1 = PV, 2 = NF, 3 = FA respectively.',
  
	-- Html Link	
	DRILL_TO_ITEMS_LINK_HTML			VARCHAR 											COMMENT 'Link to the target detailed report, which shows all items of this sub item_1 group (UWG)',
	
	-- Technical fields
	REJECT_FG					SMALLINT		NOT NULL	DEFAULT 0 						COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	REJECT_REASON_ID			INTEGER			NOT NULL	DEFAULT -1 						COMMENT 'Link to DQ Reject Reason Codes',
	SOURCE_SYSTEM_ID			INTEGER			NOT NULL	DEFAULT 0 						COMMENT 'Source System EJR / WAWI / Delivery',
	DELETED_FG					SMALLINT		NOT NULL	DEFAULT 0 						COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS				TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP() 	COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS				TIMESTAMP		 											COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID						INTEGER			NOT NULL	DEFAULT 0 						COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (CLIENT_ID, WAREHOUSE_SID, ADV_WEEK_ID, REPORTING_LINE_SID, ITEM_GRP_INT_SID, SUB_ITEM_GRP_SID, DELETED_FG)
)	COMMENT='Frontend Drilling Table, containing links from category sub item_1 group (UWG) to the items in this UWG. This table has the links for Region_1 (WH), Advertising Week. Comparison weeks are not needed, because there are no related week comparisons on item_1 level.'
;

/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_AGG_DRILL_MEDIUM_1
#-------------------------------------------------------------------------------
# Description: Create DDL for Frontend Drilling Table, containing drilling links from Advertising Medium (and Medium Group) 
# to the history of the Medium (Medium Group) via calendar_1 icon and separately to its items via the magnify icon.
# This table has the links for Region_1 (WH), Advertising Week. Comparison weeks are not needed, because there are no related 
# week comparisons on history or item_1 level.
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    	Initial version
#  1.1	2021-09-13 Massimo Morelli 	Fixed SCHEMA
#  1.2  2022-01-24 Andreas Kurz		Reworked the structure after DM review
#  2.0	2022-07-12 Nikolai Toknov  Changing the script for DevOps
#  2.1	2022-07-22 Andreas Kurz		Added _GID columns for MSTR As-Was Join
#  2.2  2022-10-12 Nikolai Toknov   Add CLUSTER BY (CLIENT_ID)
#  2.3  2023-01-25 Andreas Kurz		Adding ACTION_TYPE_ID Column Default -1000 n/A
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#  5.0  2024-06-20 K Lukaszewska	Added column DRILL_TO_ITEMS_LINK_HTML_FILIAL
#  5.1  2024-07-17 K Lukaszewska	Added column DRILL_TO_HIST_LINK_HTML_FILIAL
#  5.2  2025-02-10 K Lukaszewska		Reworked Structure based on Increment PV 2.1 business requirements (FE-MSTR)
#-------------------------------------------------------------------------------
*/

/*

USE ROLE			R_LDL_D_PIT_ETL;
USE WAREHOUSE		WH_LDL_D_PIT_ETL_S;
USE DATABASE		LDL_PRODUCTION_CLONE_PIT_R60001;
--USE DATABASE		LDL_PRODUCTION_CLONE_PIT_CLONE_AP0123442_AKTIONSTYPEN;
--USE DATABASE 		LDL_PRODUCTION_CLONE_HRK2EUR_PIT;
USE SCHEMA			P_LEW_MART_PIT_1;

ALTER TABLE P_LEW_FE_MSTR_PIT.T_AGG_DRILL_MEDIUM_1
DROP COLUMN DRILL_TO_HIST_LINK_HTML_FILIAL
DROP COLUMN DRILL_TO_ITEMS_LINK_HTML_FILIAL

DESC TABLE P_LEW_FE_MSTR_PIT.T_AGG_DRILL_MEDIUM_1
*/

CREATE TABLE P_LEW_FE_MSTR_PIT.T_AGG_DRILL_MEDIUM_1 CLUSTER BY (CLIENT_ID) (
	
	CLIENT_ID						INTEGER			NOT NULL 									COMMENT 'Client id',
								
	COUNTRY_ISO_CD					VARCHAR(3) 													COMMENT 'Country_1 ISO Code = WAWI Country_1 ',
	COUNTRY_DESCR					VARCHAR 													COMMENT 'Country_1 Name',

	-- GID
	WAREHOUSE_GID					INTEGER		 	NOT NULL	DEFAULT -1000					COMMENT 'Warehouse Surrogate GID - As-Was Join key for Frontend',	
	WAREHOUSE_MSTR_GID 				INTEGER 													COMMENT 'Technical Field: MSTR GID',

	
	WAREHOUSE_SID					INTEGER			NOT NULL 									COMMENT 'Warehouse Surrogate ID',
	WAREHOUSE_MSTR_SID				INTEGER		 												COMMENT 'Warehouse Surrogate ID',
	WAREHOUSE_NAME					VARCHAR 													COMMENT 'Warehouse Name',
	ORIG_WH_NR						INTEGER		 												COMMENT 'Original Warehouse NUMBER / code from Wawi',
	
	ADV_WEEK_ID						INTEGER			NOT NULL 									COMMENT 'Advertising week BK',
	ADV_WEEK_MSTR_ID				INTEGER		 												COMMENT 'Advertising week MSTR Key (AdvWeek No. concatenated with 2-digit client ID)',
	
--   RLTD_ADV_WEEK_ID				INTEGER			NOT NULL 									COMMENT 'Advertising Week (Related) - Vergleichswerbewoche',				
--   RLTD_ADV_WEEK_MSTR_ID	        INTEGER		 												COMMENT 'Advertising week MSTR Key Related Vergleichswoche (AdvWeek No. concatenated with 2-digit client ID)',
	
	REPORTING_LINE_SID				INTEGER			NOT NULL 									COMMENT 'Hierarchy_1 level NUMBER to identify the individual reporting line (row) of e.g. a precalculated summary line.',
	REPORTING_LINE_DESCR			VARCHAR 													COMMENT 'Description of the Reporting Line',
				
	MEDIUM_SID						INTEGER			NOT NULL 									COMMENT 'Advertising Medium SID',
	MEDIUM_MSTR_SID					INTEGER		 												COMMENT 'Advertising Medium SID (MicroStrategy Formatted)',
	MEDIUM_NAME						VARCHAR 													COMMENT '(short) medium name in local LANGUAGE',
	
	MEDIUM_GRP_SID					INTEGER			NOT NULL 									COMMENT 'Advertising Medium Group SID',
	MEDIUM_GRP_MSTR_SID				INTEGER		 												COMMENT 'Advertising Medium Group SID (MicroStrategy Formatted)',
	MEDIUM_GRP_NAME					VARCHAR 													COMMENT 'Medium group name.',
													
	-- AKU 2023-01-24 ACTION_TYPE_ID INTEGER
	ACTION_TYPE_ID 					INTEGER			NOT NULL DEFAULT -1000						COMMENT 'Action type id. -2000 = Reporting Line Total, -1000 = Undefined/No Action, 1 = PV, 2 = NF, 3 = FA respectively.',
													
    -- Html Links													
	DRILL_TO_ITEMS_LINK_HTML		VARCHAR 													COMMENT 'Link to the target detailed report, which shows all items of this adv medium (or adv medium group, distinguished by reporting line)',
	DRILL_TO_HIST_LINK_HTML			VARCHAR 													COMMENT 'Link to the target detailed report, which shows the history of this adv medium (or adv medium group, distinguished by reporting line): The previous advertising weeks, in which there have been advertisings in this medium or medium group.',
    
	-- Technical fields
	REJECT_FG						SMALLINT		NOT NULL	DEFAULT 0 						COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	REJECT_REASON_ID				INTEGER			NOT NULL	DEFAULT -1 						COMMENT 'Link to DQ Reject Reason Codes',
	SOURCE_SYSTEM_ID				INTEGER			NOT NULL	DEFAULT 0 						COMMENT 'Source System EJR / WAWI / Delivery',
	DELETED_FG						SMALLINT		NOT NULL	DEFAULT 0 						COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS					TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP() 	COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS					TIMESTAMP		 											COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID							INTEGER			NOT NULL	DEFAULT 0 						COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (CLIENT_ID, WAREHOUSE_SID, ADV_WEEK_ID, REPORTING_LINE_SID, MEDIUM_SID, MEDIUM_GRP_SID, DELETED_FG)
)	COMMENT='Frontend Drilling Table, containing drilling links from Advertising Medium (and Medium Group) to the history of the Medium (Medium Group) via calendar_1 icon and separately to its items via the magnify icon. This table has the links for Region_1 (WH), Advertising Week. Comparison weeks are not needed, because there are no related week comparisons on history or item_1 level.'
;

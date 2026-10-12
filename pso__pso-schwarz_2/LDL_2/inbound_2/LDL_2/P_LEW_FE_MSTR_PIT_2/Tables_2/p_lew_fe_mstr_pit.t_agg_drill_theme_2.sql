/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_AGG_DRILL_THEME_2
#-------------------------------------------------------------------------------
# Description: Create DDL for Frontend Drilling Table, containing links from Advertising Theme to the history of the Theme via 
# calendar_2 icon and separately to its items via the magnify icon. This table has the links for Region_2 (WH), Advertising Week. 
# Comparison weeks are not needed, because there are no related week comparisons on history or item_2 level.
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    	Initial version
#  1.1  2021-08-12 Dirk Hering     	Fixes, formatting
#  1.2	2021-09-13 Massimo Morelli 	Fixed SCHEMA
#  1.3  2022-01-24 Andreas Kurz		Reworked the structure after DM review
#  1.4  2022-07-08 Dirk Hering      Changed THEME_... to THEME_GRP_... columns
#  2.0	2022-07-12 Nikolai Toknov  Changing the script for DevOps
#  2.1	2022-07-22 Andreas Kurz		Added _GID columns for MSTR As-Was Join
#  2.2  2022-10-12 Nikolai Toknov   Add CLUSTER BY (CLIENT_ID)
#  2.3  2023-01-25 Andreas Kurz		Adding ACTION_TYPE_ID Column Default -1000 n/A
#  3.0	2023-06-26 Nikolai Toknov	INT/NAT. Release v.5.15. AP0100400_BS0011293_PIT_REPORTING_ADV_THEMA_NAT/INT - Promotion Impact Tracker - IT-Documentation (itdoc.schwarz) 
#  3.1  2023-09-06 Andreas Kurz 	Changes INT/NAT. Release v.5.15. B-0011293A-AP0186978 Anpassung Mapping INT / NAT aus APT
#									Adding THEME_GRP_CAT MSTR attributes
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#  5.0  2024-06-19 K Lukaszewska	Column DRILL_TO_ITEMS_LINK_HTML_FILIAL added
#  5.1	2025-03-05 K Lukaszewska	Reworked Structure based on Increment PV 2.1 business requirements (FE-MSTR)
#-------------------------------------------------------------------------------
*/

/*

USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R51501;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 

--DROP TABLE P_LEW_FE_MSTR_PIT.T_AGG_DRILL_THEME_2;
*/

CREATE TABLE P_LEW_FE_MSTR_PIT.T_AGG_DRILL_THEME_2 CLUSTER BY (CLIENT_ID) (
	
	CLIENT_ID					INTEGER			NOT NULL 									COMMENT 'Client id',
				
	COUNTRY_ISO_CD				VARCHAR(3) 													COMMENT 'Country_2 ISO Code = WAWI Country_2 ',
	COUNTRY_DESCR				VARCHAR 													COMMENT 'Country_2 Name',

	-- GID
	WAREHOUSE_GID				INTEGER		 	NOT NULL	DEFAULT -1000					COMMENT 'Warehouse Surrogate GID - As-Was Join key for Frontend',	
	WAREHOUSE_MSTR_GID 			INTEGER 													COMMENT 'Technical Field: MSTR GID',
	
	WAREHOUSE_SID				INTEGER			NOT NULL 									COMMENT 'Warehouse Surrogate ID',
	WAREHOUSE_MSTR_SID			INTEGER		 												COMMENT 'Warehouse Surrogate ID MSTR Key',
	WAREHOUSE_NAME				VARCHAR 													COMMENT 'Warehouse Name',
	ORIG_WH_NR					INTEGER		 												COMMENT 'Original Warehouse NUMBER / code from Wawi',
	
	ADV_WEEK_ID					INTEGER			NOT NULL 									COMMENT 'Advertising week BK',
	ADV_WEEK_MSTR_ID			INTEGER		 												COMMENT 'Advertising week MSTR Key (AdvWeek No. concatenated with 2-digit client ID)',
	
	REPORTING_LINE_SID			INTEGER			NOT NULL 									COMMENT 'Hierarchy_2 level NUMBER to identify the individual reporting line (row) of e.g. a precalculated summary line.',
	REPORTING_LINE_DESCR		VARCHAR 													COMMENT 'Description of the Reporting Line',
	
	THEME_GRP_TYPE_ID					INTEGER			NOT NULL	DEFAULT -1 					COMMENT 'Unique ID.See COMMENTs below.',
--	FE_MSTR_RELEVANT_FG					SMALLINT					DEFAULT 0 					COMMENT 'Flag indicates if used on FE_MSTR',
	THEME_GRP_TYPE_SORT_VAL				INTEGER		 											COMMENT 'Sort information for reporting purposes.',
	THEME_GRP_TYPE_NAME					VARCHAR 												COMMENT '(short) name in local LANGUAGE',
	THEME_GRP_TYPE_DESCR				VARCHAR 												COMMENT '(long)  description in local LANGUAGE (may be unavailable)',

	THEME_GRP_INT_SID					INTEGER		 	NOT NULL	DEFAULT -1000				COMMENT ' Unique system ID, sid, for the theme int group.',
	THEME_GRP_INT_MSTR_SID				INTEGER													COMMENT ' Unique system ID, sid, for the theme int group + Client_ID, as MSTR Key',
	THEME_GRP_INT_NAME					VARCHAR 												COMMENT ' Theme int group name.',
	THEME_GRP_INT_SORT_VAL				INTEGER		 											COMMENT ' internal sorting value for the int theme (ordered by Theme group Name)',
		
	THEME_GRP_NAT_SID					INTEGER		 	NOT NULL	DEFAULT -1000				COMMENT ' Unique system ID, sid, for the theme nat group.',
	THEME_GRP_NAT_MSTR_SID				INTEGER													COMMENT ' Unique system ID, sid, for the theme nat group + Client_ID, as MSTR Key',
	THEME_GRP_NAT_NAME					VARCHAR 												COMMENT ' Theme nat group name.',
	THEME_GRP_NAT_SORT_VAL				INTEGER		 											COMMENT ' internal sorting value for the nat theme (ordered by Theme group Name)',

	THEME_GRP_NAT_CAT_SID				INTEGER		 	NOT NULL	DEFAULT -1000				COMMENT ' Unique system ID, sid, for the theme nat group category.',
	THEME_GRP_NAT_CAT_MSTR_SID			INTEGER													COMMENT ' Unique system ID, sid, for the theme nat group category + Client_ID, as MSTR Key',
	THEME_GRP_NAT_CAT_NAME				VARCHAR 												COMMENT ' Theme nat group name category.',
	THEME_GRP_NAT_CAT_SORT_VAL			INTEGER		 											COMMENT ' internal sorting value for the nat theme category (ordered by Theme group Name)',

	THEME_GRP_MAIN_MSTR_SID				INTEGER													COMMENT ' Unique system ID, sid, for the theme group + Client_ID, as MSTR Key',
	THEME_GRP_MAIN_NAME					VARCHAR 												COMMENT ' Theme group name.',

	-- AKU 2023-01-24 ACTION_TYPE_ID INTEGER
	ACTION_TYPE_ID 				INTEGER			NOT NULL DEFAULT -1000						COMMENT 'Action type id.2000 = Reporting Line Total, -1000 = Undefined/No Action, 1 = PV, 2 = NF, 3 = FA respectively.',
    -- Html Link	
	DRILL_TO_ITEMS_LINK_HTML			VARCHAR 													COMMENT 'Link to the target detailed report, which shows all items of this adv theme',
	DRILL_TO_HIST_LINK_HTML				VARCHAR 													COMMENT 'Link to the target detailed report, which shows the history of this adv theme: The previous advertising weeks, in which there have been advertisings in this theme.',

    -- Technical fields	
	REJECT_FG					SMALLINT		NOT NULL	DEFAULT 0 						COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	REJECT_REASON_ID			INTEGER			NOT NULL	DEFAULT -1 						COMMENT 'Link to DQ Reject Reason Codes',
	SOURCE_SYSTEM_ID			INTEGER			NOT NULL	DEFAULT 0 						COMMENT 'Source System EJR / WAWI / Delivery',
	DELETED_FG					SMALLINT		NOT NULL	DEFAULT 0 						COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS				TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP() 	COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS				TIMESTAMP		 											COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID						INTEGER			NOT NULL	DEFAULT 0 						COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (CLIENT_ID, WAREHOUSE_SID, ADV_WEEK_ID, REPORTING_LINE_SID, THEME_GRP_INT_SID, THEME_GRP_NAT_SID, DELETED_FG)
)	COMMENT='Frontend Drilling Table, containing links from Advertising Theme to the history of the Theme via calendar_2 icon and separately to its items via the magnify icon. This table has the links for Region_2 (WH), Advertising Week. Comparison weeks are not needed, because there are no related week comparisons on history or item_2 level.'
;
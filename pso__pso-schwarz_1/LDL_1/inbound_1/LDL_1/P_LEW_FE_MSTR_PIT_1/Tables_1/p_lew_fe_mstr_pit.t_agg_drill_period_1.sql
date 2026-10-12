/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025 
#-------------------------------------------------------------------------------
# Interface : DDL for T_AGG_DRILL_PERIOD_1
#-------------------------------------------------------------------------------
# Describtion: Create DDL for Frontend Drilling Table, containing links from Advertising Period 
# (or Action Type Total) to the Items of this period (action type). This table has the links for Region_1 (WH), 
# Advertising Week. Comparison weeks are not needed, because there are no related week comparisons on item_1 level.
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
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#  5.0  2024-06-20 K Lukaszewska	Column DRILL_TO_ITEMS_LINK_HTML_FILIAL added
#  5.1  2025-03-05 K Lukaszewska	Reworked Structure based on Increment PV 2.1 business requirements (FE-MSTR)
#-------------------------------------------------------------------------------
*/

/*
USE ROLE			R_LDL_D_PIT_ETL;
USE WAREHOUSE		WH_LDL_D_PIT_ETL_S;
USE DATABASE		LDL_PRODUCTION_CLONE_PIT_R60001;
--USE DATABASE		LDL_PRODUCTION_CLONE_PIT_CLONE_AP0123442_AKTIONSTYPEN;
--USE DATABASE 		LDL_PRODUCTION_CLONE_HRK2EUR_PIT;
USE SCHEMA			P_LEW_MART_PIT_1;

DESC TABLE P_LEW_FE_MSTR_PIT.T_AGG_DRILL_PERIOD_1
*/ 

CREATE TABLE P_LEW_FE_MSTR_PIT.T_AGG_DRILL_PERIOD_1 CLUSTER BY (CLIENT_ID) (
	
	CLIENT_ID						INTEGER			NOT NULL 									COMMENT 'Client id',
				
	COUNTRY_ISO_CD					VARCHAR(3) 													COMMENT 'Country_1 ISO Code = WAWI Country_1 ',
	COUNTRY_DESCR					VARCHAR 													COMMENT 'Country_1 Name',

	-- GID
	WAREHOUSE_GID					INTEGER		 	NOT NULL	DEFAULT -1000					COMMENT 'Warehouse Surrogate GID - As-Was Join key for Frontend',	
	WAREHOUSE_MSTR_GID 				INTEGER 													COMMENT 'Technical Field: MSTR GID',
	
	WAREHOUSE_SID					INTEGER			NOT NULL 									COMMENT 'Warehouse Surrogate ID',
	WAREHOUSE_MSTR_SID				INTEGER		 												COMMENT '[VC] Warehouse Surrogate ID',
	WAREHOUSE_NAME					VARCHAR 													COMMENT 'Warehouse Name',
	ORIG_WH_NR						INTEGER		 												COMMENT 'Original Warehouse NUMBER / code from Wawi',
	
	ADV_WEEK_ID						INTEGER			NOT NULL 									COMMENT 'Advertising week BK',
	ADV_WEEK_MSTR_ID				INTEGER		 												COMMENT 'Advertising week MSTR Key(AdvWeek No. concatenated with 2-digit client ID)',
					
--    RLTD_ADV_WEEK_ID				INTEGER			NOT NULL 									COMMENT 'Advertising Week (Related) - Vergleichswerbewoche',				
--    RLTD_ADV_WEEK_MSTR_ID	        INTEGER		 												COMMENT 'Advertising week MSTR Key Related Vergleichswoche (AdvWeek No. concatenated with 2-digit client ID)',
	
	ACTION_TYPE_ID					INTEGER			NOT NULL 									COMMENT 'Action type id.-2 = Reporting Line Total, -1 = Undefined/No Action, 1 = PV, 2 = NF, 3 = FA respectively.',
	ACTION_TYPE_NAME				VARCHAR 													COMMENT '(short) name in local LANGUAGE',
	
	ADV_PERIOD_ID					INTEGER			NOT NULL 									COMMENT 'Unique identifier of Adv. Period',
	ADV_PERIOD_MSTR_ID				INTEGER		 												COMMENT '[VC] Needed for MSTR Reportinge.g. 2021241304 Adv.Period from Mon to Wednesday Adv.Week 2021/24 for Country_1 04 (CH)',
	ADV_PERIOD_DESCR				VARCHAR 													COMMENT 'Adv. Period Description',

    -- Html Link	
	DRILL_TO_ITEMS_LINK_HTML		VARCHAR 													COMMENT 'Link to the target detailed report, which shows all items of this adv theme',

    -- Technical fields	
	REJECT_FG						SMALLINT		NOT NULL	DEFAULT 0 						COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	REJECT_REASON_ID				INTEGER			NOT NULL	DEFAULT -1 						COMMENT 'Link to DQ Reject Reason Codes',
	SOURCE_SYSTEM_ID				INTEGER			NOT NULL	DEFAULT 0 						COMMENT 'Source System EJR / WAWI / Delivery',
	DELETED_FG						SMALLINT		NOT NULL	DEFAULT 0 						COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS					TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP()		COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS					TIMESTAMP		 											COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID							INTEGER			NOT NULL	DEFAULT 0 						COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (CLIENT_ID, WAREHOUSE_SID, ADV_WEEK_ID, ACTION_TYPE_ID, ADV_PERIOD_ID, DELETED_FG)
)	COMMENT='Frontend Drilling Table, containing links from Advertising Period (or Action Type Total) to the Items of this period (action type). This table has the links for Region_1 (WH), Advertising Week. Comparison weeks are not needed, because there are no related week comparisons on item_1 level.'
;
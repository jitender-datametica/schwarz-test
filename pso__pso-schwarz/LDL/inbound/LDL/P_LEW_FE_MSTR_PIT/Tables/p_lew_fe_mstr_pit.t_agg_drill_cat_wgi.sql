/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_AGG_DRILL_CAT_WGI
#-------------------------------------------------------------------------------
# Description: Create DDL for Frontend Drilling Table, containing links from category item group international (WGI) 
# to the category sub item groups (UWGs) in this WGI. This table has the links for Region (WH), Advertising Week, 
# compared to a related Advertising week, which could be up to 53 weeks in the past.
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
#  4.1	2024-07-08 K Lukaszewska	Column DRILL_TO_UWGS_LINK_HTML_FILIAL added
#  4.2  2025-03-05 K Lukaszewska	Reworked Structure based on Increment PV 2.1 business requirements (FE-MSTR)
#  4.3  2025-03-24 Nikolai Toknov	Change for Azure-pipeline
#-------------------------------------------------------------------------------
*/

/*

USE ROLE			R_LDL_D_PIT_ETL;
USE WAREHOUSE		WH_LDL_D_PIT_ETL_S;
--USE DATABASE		LDL_PRODUCTION_CLONE_PIT;
USE DATABASE		LDL_PRODUCTION_CLONE_PIT_CLONE_AP0123442_AKTIONSTYPEN;
--USE DATABASE 		LDL_PRODUCTION_CLONE_HRK2EUR_PIT;
USE SCHEMA			P_LEW_MART_PIT;

ALTER TABLE P_LEW_FE_MSTR_PIT.T_AGG_DRILL_CAT_WGI
ADD ACTION_TYPE_ID 				INTEGER			NOT NULL DEFAULT -1000						COMMENT 'Action type id. -2000 = Reporting Line Total, -1000 = Undefined/No Action, 1 = PV, 2 = NF, 3 = FA respectively.'
;

*/

CREATE TABLE P_LEW_FE_MSTR_PIT.T_AGG_DRILL_CAT_WGI  CLUSTER BY (CLIENT_ID) (
	
	CLIENT_ID					INTEGER			NOT NULL 									COMMENT 'Client id',
	COUNTRY_ISO_CD				VARCHAR(3) 													COMMENT 'Country ISO Code = WAWI Country ',
	COUNTRY_DESCR				VARCHAR 													COMMENT 'Country Name',

	-- GID
	WAREHOUSE_GID				INTEGER		 	NOT NULL	DEFAULT -1000					COMMENT 'Warehouse Surrogate GID - As-Was Join key for Frontend',	
	WAREHOUSE_MSTR_GID 			INTEGER 	 												COMMENT 'Technical Field: MSTR GID',

	
	WAREHOUSE_SID				INTEGER			NOT NULL 									COMMENT 'Warehouse Surrogate ID',
	WAREHOUSE_MSTR_SID			INTEGER		 												COMMENT 'Warehouse Surrogate ID',
	WAREHOUSE_NAME				VARCHAR 													COMMENT 'Warehouse Name',
	ORIG_WH_NR					INTEGER		 												COMMENT 'Original Warehouse NUMBER  / code from Wawi',
	
	ADV_WEEK_ID					INTEGER			NOT NULL 									COMMENT 'Advertising week BK',
	ADV_WEEK_MSTR_ID			INTEGER		 												COMMENT 'Advertising week MSTR Key (AdvWeek No. concatenated with 2-digit client ID)',

	-- RLTD_ADV_WEEK_ID			INTEGER			NOT NULL 									COMMENT 'Related Adv week BK. The adv week for comparison.',
	-- RLTD_ADV_WEEK_MSTR_ID		INTEGER		 											COMMENT 'Related Adv week MSTR Key. (AdvWeek No. concatenated with 2-digit client ID). The adv week for comparison.',

	REPORTING_LINE_SID			INTEGER			NOT NULL 									COMMENT 'Hierarchy level NUMBER to identify the individual reporting line (row) of e.g. a precalculated summary line.',
	REPORTING_LINE_DESCR		VARCHAR 													COMMENT 'Description of the Reporting Line',

	-- WGI
	ITEM_GRP_INT_GID			INTEGER			NOT NULL	DEFAULT -1000					COMMENT 'UWG orig Item number Surrogate GID - As-Was Join key for Frontend',		
	ITEM_GRP_INT_MSTR_GID 		INTEGER 													COMMENT 'Technical Field: MSTR GID',			

	ITEM_GRP_INT_SID			INTEGER			NOT NULL 									COMMENT 'SID for item group international (WGI)',
	ITEM_GRP_INT_MSTR_SID		INTEGER		 												COMMENT 'SID for item group international (WGI) (MSTR formatted)',
	ITEM_GRP_INT_SRC_CD			VARCHAR 													COMMENT 'Item Code for international group from source system.',
	ITEM_GRP_INT_NAME			VARCHAR 													COMMENT 'Item International group name.',

	-- AKU 2023-01-24 ACTION_TYPE_ID INTEGER
	ACTION_TYPE_ID 				INTEGER			NOT NULL DEFAULT -1000						COMMENT 'Action type id. -2000 = Reporting Line Total, -1000 = Undefined/No Action, 1 = PV, 2 = NF, 3 = FA respectively.',
							
    -- Html Link							
	DRILL_TO_UWGS_LINK_HTML				VARCHAR 											COMMENT 'Link to the target detailed report, which shows all UWGs of this item group international (WGI)',

    -- Technical fields
	REJECT_FG					SMALLINT		NOT NULL	DEFAULT 0 						COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	REJECT_REASON_ID			INTEGER			NOT NULL	DEFAULT -1 						COMMENT 'Link to DQ Reject Reason Codes',
	SOURCE_SYSTEM_ID			INTEGER			NOT NULL	DEFAULT 0 						COMMENT 'Source System EJR / WAWI / Delivery',
	DELETED_FG					SMALLINT		NOT NULL	DEFAULT 0 						COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS				TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP() 	COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS				TIMESTAMP		 											COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID						INTEGER			NOT NULL	DEFAULT 0 						COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (CLIENT_ID, WAREHOUSE_SID, ADV_WEEK_ID, REPORTING_LINE_SID, ITEM_GRP_INT_SID, DELETED_FG)
)	COMMENT='Frontend Drilling Table, containing links from category item group international (WGI) to the category sub item groups (UWGs) in this WGI. This table has the links for Region (WH), Advertising Week, compared to a related Advertising week, which could be up to 53 weeks in the past.'
;

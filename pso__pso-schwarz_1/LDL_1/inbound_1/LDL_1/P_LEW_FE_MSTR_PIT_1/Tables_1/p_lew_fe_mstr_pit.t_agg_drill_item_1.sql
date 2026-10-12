/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_AGG_DRILL_ITEM_1
#-------------------------------------------------------------------------------
# Description: Create DDL for Frontend Drilling Table, containing links from each individual item_1 to the history 
# of this item_1 (the previous advertising weeks, in which this item_1 was advertised).
# This table has the links for Region_1 (WH) and Advertising Week, no comparison weeks on item_1 level.
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
#-------------------------------------------------------------------------------
*/

CREATE TABLE P_LEW_FE_MSTR_PIT.T_AGG_DRILL_ITEM_1  CLUSTER BY (CLIENT_ID) (
	
	CLIENT_ID				INTEGER			NOT NULL 									COMMENT 'Client id',
				
	COUNTRY_ISO_CD			VARCHAR(3) 													COMMENT 'Country_1 ISO Code = WAWI Country_1 ',
	COUNTRY_DESCR			VARCHAR 													COMMENT 'Country_1 Name',
				
	-- GID
	WAREHOUSE_GID			INTEGER		 	NOT NULL	DEFAULT -1000					COMMENT 'Warehouse Surrogate GID - As-Was Join key for Frontend',	
	WAREHOUSE_MSTR_GID 		INTEGER 													COMMENT 'Technical Field: MSTR GID',

				
	WAREHOUSE_SID			INTEGER			NOT NULL 									COMMENT 'Warehouse Surrogate ID',
	WAREHOUSE_MSTR_SID		INTEGER		 												COMMENT 'Warehouse Surrogate ID',
	WAREHOUSE_NAME			VARCHAR 													COMMENT 'Warehouse Name',
	ORIG_WH_NR				INTEGER		 												COMMENT 'Original Warehouse			NUMBER  / code from Wawi',
				
	ADV_WEEK_ID				INTEGER			NOT NULL 									COMMENT 'Advertising week BK',
	ADV_WEEK_MSTR_ID		INTEGER		 												COMMENT 'Advertising week MSTR Key (AdvWeek No. concatenated with 2-digit client ID)',
		
	-- GID
	ORIG_ITEM_GID			INTEGER			NOT NULL	DEFAULT -1000					COMMENT 'NAN orig Item_1 number Surrogate GID - As-Was Join key for Frontend',	
	ORIG_ITEM_MSTR_GID 		INTEGER 													COMMENT 'Technical Field: MSTR GID',								

		
	ORIG_ITEM_NR			INTEGER			NOT NULL 									COMMENT 'Item_1 business identifier.NaN := National Article			NUMBER',
	ORIG_ITEM_MSTR_NR		INTEGER		 												COMMENT 'Item_1 business identifier.(NaN := National Article			NUMBER) MSTR Key: Special MSTR Join criteria to have surrogate ORIG_ITEM_NR + CLIENT_ID',
	ITEM_INT_DESCR			VARCHAR 													COMMENT '(long) item_1 description in international LANGUAGE of centre (Deutsch)',
								
    -- Html Link								
	DRILL_TO_HIST_LINK_HTML	VARCHAR 													COMMENT 'Link to the target detailed report, which shows the history of this item_1 (the previous advertising weeks, in which this item_1 was advertised)',
	
    -- Technical fields	
	REJECT_FG				SMALLINT		NOT NULL	DEFAULT 0 						COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	REJECT_REASON_ID		INTEGER			NOT NULL	DEFAULT -1 						COMMENT 'Link to DQ Reject Reason Codes',
	SOURCE_SYSTEM_ID		INTEGER			NOT NULL	DEFAULT 0 						COMMENT 'Source System EJR / WAWI / Delivery',
	DELETED_FG				SMALLINT		NOT NULL	DEFAULT 0 						COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS			TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP() 	COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS			TIMESTAMP		 											COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID					INTEGER			NOT NULL	DEFAULT 0 						COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (CLIENT_ID, WAREHOUSE_SID, ADV_WEEK_ID, ORIG_ITEM_NR, DELETED_FG)
)	COMMENT='Frontend Drilling Table, containing links from each individual item_1 to the history of this item_1 (the previous advertising weeks, in which this item_1 was advertised). This table has the links for Region_1 (WH) and Advertising Week, no comparison weeks on item_1 level.'
;
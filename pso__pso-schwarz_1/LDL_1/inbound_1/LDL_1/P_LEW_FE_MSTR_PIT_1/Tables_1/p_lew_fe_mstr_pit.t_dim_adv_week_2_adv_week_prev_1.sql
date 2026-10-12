/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for DIM_ADV_WEEK_2_ADV_WEEK_PREV
#-------------------------------------------------------------------------------
# Describtion: Create DDL for Adv.Period Dimension Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    Initial version
#  1.1  2021-08-23 Mike Davis      Checks, formatting, FK support (now removed)
#  1.2	2021-09-13 Massimo Morelli Fixed SCHEMA, added COMMIT
#  2.0	2022-04-12 Nikolai Toknov  Changing the script for DevOps
#  2.1  2022-10-12 Nikolai Toknov   Add CLUSTER BY (CLIENT_ID)
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC. 
#-------------------------------------------------------------------------------
*/

/*
VC:
ADV_WEEK_MSTR_ID
ADV_WEEK_DESCR
RLTD_ADV_WEEK_MSTR_ID
RLTD_ADV_WEEK_DESCR
RLTD_ADV_WEEK_SDESCR
RLTD_ADV_WEEK_LDESCR

*/


CREATE TABLE P_LEW_FE_MSTR_PIT.T_DIM_ADV_WEEK_2_ADV_WEEK_PREV_1 CLUSTER BY (CLIENT_ID) (
	CLIENT_ID					INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Client ID e.g, AT==1',
	COUNTRY_ISO_CD				VARCHAR(3) 																COMMENT 'Country_1 ISO Code = WAWI Country_1 ',
	COUNTRY_DESCR				VARCHAR 																COMMENT 'Country_1 Name',
				
	ADV_WEEK_ID					INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Adv.Week ID',
--	ADV_WEEK_DESCR				VARCHAR 																COMMENT 'Description of Adv.-Week',
				
	RLTD_ADV_WEEK_ID			INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Prev. Adv.Week ID',
--	RLTD_ADV_WEEK_DESCR			VARCHAR 																COMMENT 'Description of previous / related Adv.-Week',
	-- AKU added 2022-05-22			
--	RLTD_ADV_WEEK_SDESCR		VARCHAR 																COMMENT 'Short Description of previous / related Adv.-Week',
--	RLTD_ADV_WEEK_LDESCR		VARCHAR 																COMMENT 'Long Description of previous / related Adv.-Week',

	RLTD_ADV_WEEK_START_DT		DATE			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_1-DD')	COMMENT 'Week Start			DATE of previous / related Adv.-Week',
	RLTD_ADV_WEEK_END_DT		DATE			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_1-DD')	COMMENT 'Week End			DATE of previous / related Adv.-Week',
	DIFF_ADV_WEEK_NR			INTEGER			NOT NULL	DEFAULT 0 									COMMENT 'Difference in Adv.-Weeks between Adv.Week and Previous Adv.-Week e.g. 202124 | 202122 à (-2)',
	NEAREST_RLTD_ADV_WEEK_FG	SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'Flag / Indicator Frontend relevant to simple filter all reltated Adv-Weeks. ',
	RELATED_TYPE_ID				INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'The type ID of the related week comparison',
	RELATED_TYPE_DESCR			VARCHAR			NOT NULL	DEFAULT 'N/A' 								COMMENT 'The German type description of the related week  comparison, to show in the reporting',
    -- Technical fields
	REJECT_FG					SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	REJECT_REASON_ID			INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Link to DQ Reject Reason Codes',
	SOURCE_SYSTEM_ID			INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Technical Field: Source System. E.g. Manual / Static / PIT Internal / EJR / WAWI / Delivery / ADP',
	DELETED_FG					SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS 				TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP() 				COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS 				TIMESTAMP		 														COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID						INTEGER			NOT NULL	DEFAULT 0 									COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (CLIENT_ID, ADV_WEEK_ID, RLTD_ADV_WEEK_ID, RELATED_TYPE_ID, DELETED_FG)
)	COMMENT='Dimension table for Adv.-Week';
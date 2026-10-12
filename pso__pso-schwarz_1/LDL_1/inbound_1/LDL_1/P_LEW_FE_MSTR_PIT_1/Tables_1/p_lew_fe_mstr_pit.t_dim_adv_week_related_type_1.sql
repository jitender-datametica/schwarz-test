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
#-------------------------------------------------------------------------------
*/

CREATE TABLE P_LEW_FE_MSTR_PIT.T_DIM_ADV_WEEK_RELATED_TYPE_1 (
	RELATED_TYPE_ID			INTEGER			NOT NULL	DEFAULT -1 						COMMENT 'The type ID of the related week comparison',
	RELATED_TYPE_DESCR		VARCHAR						DEFAULT 'N/A' 					COMMENT 'The German type description of the related week  comparison, to show in the reporting',
    -- Technical fields
	REJECT_FG				SMALLINT		NOT NULL	DEFAULT 0 						COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	REJECT_REASON_ID		INTEGER			NOT NULL	DEFAULT -1 						COMMENT 'Link to DQ Reject Reason Codes',
	SOURCE_SYSTEM_ID		INTEGER			NOT NULL	DEFAULT -1 						COMMENT 'Technical Field: Source System. E.g. Manual / Static / PIT Internal / EJR / WAWI / Delivery / ADP',
	DELETED_FG				SMALLINT		NOT NULL	DEFAULT 0 						COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS 			TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP() 	COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS 			TIMESTAMP		 											COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID					INTEGER			NOT NULL	DEFAULT 0 						COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (RELATED_TYPE_ID, DELETED_FG)
)	COMMENT='Dimension table for Adv.-Week Related Type'
;


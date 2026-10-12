/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025 
#-------------------------------------------------------------------------------
# Interface : DDL for T_CNTL_FE_MSTR_REPORTING_LINES_2
#-------------------------------------------------------------------------------
# Describtion: Create DDL for Adv.Period Dimension Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    Initial version
#  1.1  2021-08-20 Mike Davis      Checks formatting FK support (now removed)
#  1.2	2021-09-13 Massimo Morelli Fixed SCHEMA added COMMIT
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/
/*
VC
REPORTING_LINE_SID
*/

CREATE TABLE P_LEW_FE_MSTR_PIT.T_CNTL_FE_MSTR_REPORTING_LINES_2 (
	REPORTING_LINE_ID                 SMALLINT 	DEFAULT 1                         NOT NULL    	COMMENT 'Unique ID of Reporting Hierarchie Line',
	REPORTING_LINE_DESCR              VARCHAR                                                		COMMENT 'Description of the Reporting Line',
	REPORTING_TYPE_ID                 SMALLINT 	DEFAULT 1                         NOT NULL    	COMMENT 'Unique ID of Reporting Hierarchie Type',
	REPORTING_TYPE_DESCR              VARCHAR                                                 	COMMENT 'Description of the type (e.g. regarded dimension) of the reporting page',
	REPORTING_LINE_SID                INTEGER 													COMMENT 'Simple SID of the reporting line to have a unique Join',
	FE_MSTR_RELEVANT_FG               SMALLINT 	DEFAULT 1                         NOT NULL    	COMMENT 'Flag indicates if used on FE_MSTR',
	-- Technical fields
	REJECT_FG                         SMALLINT 	DEFAULT 0                         NOT NULL    	COMMENT 'Flag indicates if record was rejected by DQ Rule e.g. 1/0 or similar data issues',
	REJECT_REASON_ID                  INTEGER 	DEFAULT -1                        NOT NULL    	COMMENT 'Link to DQ Reject Reason Codes',
	SOURCE_SYSTEM_ID                  INTEGER 	DEFAULT 0                         NOT NULL    	COMMENT 'Source System EJR / WAWI / Delivery',
	DELETED_FG                        SMALLINT 	DEFAULT 0                         NOT NULL    	COMMENT 'Logical Deleted Flag indicates if the record was logically deleted',
	DWH_CREATED_TS                    TIMESTAMP DEFAULT CURRENT_TIMESTAMP()       NOT NULL    	COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS                    TIMESTAMP                                               	COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID                           INTEGER 	DEFAULT 0                         NOT NULL    	COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (REPORTING_LINE_SID, FE_MSTR_RELEVANT_FG, DELETED_FG)
) COMMENT = 'Dimension Table for Frontend Reporting Lines'
;
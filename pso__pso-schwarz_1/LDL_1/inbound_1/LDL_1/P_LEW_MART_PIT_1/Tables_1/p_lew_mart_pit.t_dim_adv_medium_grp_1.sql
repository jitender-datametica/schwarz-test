/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for DIM_ADV_MEDIUM_GRP
#-------------------------------------------------------------------------------
# Description: Create DDL for static Medium Group Dimension
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-10-01 Aparna Rayanki    Initial version
#  1.1  2022-10-01 Mike Davis        Change name
#                                    Move group name in case we want it for the sid
#                                    Add	DEFAULT versioning
#  1.2  2022-04-01 Mike Davis        add mstr_sid
#  2.0	2022-07-13 Nikolai Toknov  Changing the script for DevOps
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/
/*
Questions:
    sid generation? md5 or current method (see load_static script)
*/

/*
VC:
MEDIUM_GRP_MSTR_SID
*/

CREATE TABLE P_LEW_MART_PIT.T_DIM_ADV_MEDIUM_GRP_1 CLUSTER BY (CLIENT_ID)(
	
	-- BUSINESS KEY
	CLIENT_ID					INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Client ID e.g. 1=>AT',
	COUNTRY_ISO_CD				VARCHAR(3),
	COUNTRY_DESCR				VARCHAR,
	MEDIUM_GRP_NAME				VARCHAR 																COMMENT 'Medium group name.',
	
	-- TECHNICAL KEYS
	MEDIUM_GRP_SID				INTEGER			NOT NULL 												COMMENT 'Unique system ID, sid, for the medium group.',	
	-- DATA 
	MEDIUM_GRP_SORT_VAL			INTEGER			NOT NULL	DEFAULT CAST(99 AS INTEGER)					COMMENT 'internal sorting value for the medium group',
	MEDIUM_GRP_IGNORE_FG		SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'ignore flag for the medium group',
	MEDIUM_GRP_ALWAYS_VIS_FG	SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'visible flag for the medium group',
	
	-- Versioning 
	VALID_FROM_DT				DATE			NOT NULL	DEFAULT TO_DATE('1900-01-01', 'YYYY-MM_1-DD'),
	VALID_TO_DT					DATE			NOT NULL	DEFAULT TO_DATE('9999-12-31', 'YYYY-MM_1-DD'),
	VERSION_NR					INTEGER			NOT NULL	DEFAULT 0,
	CURRENT_FG					SMALLINT		NOT NULL	DEFAULT 1,
	
	-- Technical Fields    	
	REJECT_FG					SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	REJECT_REASON_ID			INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Link to DQ Reject Reason Codes',
	SOURCE_SYSTEM_ID			INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Technical Field: Source System. E.g. Manual / Static / PIT Internal / EJR / WAWI / Delivery / ADP',
	DELETED_FG					SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS				TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP() 				COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS				TIMESTAMP		 														COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID						INTEGER			NOT NULL	DEFAULT 0 									COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (CLIENT_ID, MEDIUM_GRP_SID, VALID_FROM_DT, DELETED_FG)
)	COMMENT='Control Table with Medium Static Data'
;
/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for DIM_ADV_MEDIUM_HIER
#-------------------------------------------------------------------------------
# Describtion: Create DDL for flattened and Daily sliced Medium Dimension
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    	Initial version
#  1.1  2021-08-20 Mike Davis      	Checks, formatting, FK support (now removed)
#  1.2  2022-03-13 Mike Davis      	Bring into line with current PitOnCloud
#  1.4  2022-04-05 Mike Davis      	mstr_sids now from the medium to group mapping
#  1.5  2022-07-06 Andreas Kurz		Reworked structured aligned naming conventions
#  2.0	2022-07-13 Nikolai Toknov  Changing the script for DevOps
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/

/*
VC:
MEDIUM_MSTR_SID
MEDIUM_GRP_MSTR_SID
MEDIUM_NAME_UPPER ?

*/

CREATE TABLE P_LEW_MART_PIT.T_DIM_ADV_MEDIUM_HIER_1 CLUSTER BY (CLIENT_ID, DAY_DT)(
	DAY_DT					DATE			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_1-DD') COMMENT 'Calendar_1 Day of the daily sliced flattened item_1 hierarchy_1',
	CLIENT_ID				INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Client ID e.g. 1=>AT',
	COUNTRY_ISO_CD			VARCHAR(3) 																COMMENT 'Country_1 ISO Code = WAWI Country_1 ',
	COUNTRY_DESCR			VARCHAR 																COMMENT 'Country_1 Name',

	-- Medium Level - Lowest Level of Granularity
	MEDIUM_SID				INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Unique system ID, sid, for the medium (simply the channel_sid).',
--	MEDIUM_MSTR_SID			INTEGER			NOT NULL	DEFAULT -1 									COMMENT '[VC] MSTR surrogate Key',

	-- Medium Grp Level - Top Level
	MEDIUM_GRP_SID			INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Unique system ID, sid, for the medium group (simply the channel_grp_sid).',
--	MEDIUM_GRP_MSTR_SID		INTEGER			NOT NULL	DEFAULT -1 									COMMENT '[VC] MSTR surrogate Key',
	MEDIUM_NAME				VARCHAR 																COMMENT '(short) medium name in local language: first version to be found case insensitive (trimmed) - the one displayed',
--	MEDIUM_NAME_UPPER		VARCHAR 																COMMENT '(short) medium name in local language: unique version for SID (trimmed and uppercase)',
	MEDIUM_NAME_LDESCR		VARCHAR 																COMMENT '(long) medium description concate with ADP medium CD . debugging purposes',
	MEDIUM_SORT_VAL			INTEGER		 															COMMENT 'internal sorting value for the medium',
	MEDIUM_GRP_NAME			VARCHAR 																COMMENT 'Medium group name.',
	MEDIUM_GRP_SORT_VAL		INTEGER			NOT NULL	DEFAULT CAST(99 AS INTEGER) 				COMMENT 'internal sorting value for the medium',
	MEDIUM_IGNORE_FG		SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'Indicator / Flag Medium Ignore',
	MEDIUM_GRP_LIDLPLUS_FG	SMALLINT					DEFAULT 0 									COMMENT 'Indicator / Flag Medium Grouping on Lidl Plus ',

	-- Technical Fields
	REJECT_FG				SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	REJECT_REASON_ID		INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Link to DQ Reject Reason Codes',
	SOURCE_SYSTEM_ID		INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Technical Field: Source System. E.g. Manual / Static / PIT Internal / EJR / WAWI / Delivery / ADP',
	DELETED_FG				SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS			TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP() 				COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS			TIMESTAMP		 														COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID					INTEGER			NOT NULL	DEFAULT 0 									COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (CLIENT_ID, DAY_DT, MEDIUM_SID, DELETED_FG)
)	COMMENT='Dimension table item_1 hierarchy_1 - on a daily basis'
;
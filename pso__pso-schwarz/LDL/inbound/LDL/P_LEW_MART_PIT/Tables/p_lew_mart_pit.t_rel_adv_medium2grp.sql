/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for REL_ADV_MEDIUM2GRP
#-------------------------------------------------------------------------------
# Description: Create DDL for pseudo dimension holding static medium to medium group mappings
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-03-11 Mike Davis    Initial version based on OnPrem solution.
#                                Note: this is not technically a dimension, it is
#                                a relationship table. Exact name to be determined.
#  1.1  2022-03-15 Mike Davis    Change name.
#  1.2  2022-04-01 Mike Davis    add mstr_sids for both medium and medium_grp
#  2.0	2022-07-13 Nikolai Toknov  Changing the script for DevOps
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/
/*
Questions:
    think about what happens if this is not found in medium: check if medium_sid -1
    ok - it's going to be inner join so if there are any typos - can check the mapping specifically that get the same records
*/

/*
VC:
MEDIUM_MSTR_SID
MEDIUM_GRP_MSTR_SID

*/

CREATE TABLE P_LEW_MART_PIT.T_REL_ADV_MEDIUM2GRP CLUSTER BY (CLIENT_ID)(
	CLIENT_ID				INTEGER			NOT NULL	DEFAULT -1 												COMMENT 'Client ID e.g. 1=>AT',
	
	MEDIUM_SID				INTEGER			NOT NULL	DEFAULT -1 												COMMENT 'Unique system ID, sid, for the medium (from T_DIM_ADV_MEDIUM).',
	MEDIUM_GRP_SID			INTEGER			NOT NULL	DEFAULT -1 												COMMENT 'Unique system ID, sid, for the medium group (from T_DIM_ADV_MEDIUM_GRP).',

	MEDIUM_IGNORE_FG		SMALLINT		NOT NULL	DEFAULT 0 												COMMENT 'Indicator / Flag Medium Ignore: ignore this medium in this mapping.',
	MEDIUM_DELETE_FG		SMALLINT		NOT NULL	DEFAULT 0 												COMMENT 'Indicator / Flag Medium Delete: this medium has been technically deleted from this mapping.',
	
	-- Versioning
	VALID_FROM_DT			DATE			NOT NULL	DEFAULT TO_DATE('1900-01-01', 'YYYY-MM-DD') 			COMMENT 'Technical field Data Historization Valid from ',
	VALID_TO_DT				DATE			NOT NULL	DEFAULT TO_DATE('9999-12-31', 'YYYY-MM-DD') 			COMMENT 'Technical field Data Historization Valid to',
	VERSION_NR				INTEGER			NOT NULL	DEFAULT 0 												COMMENT 'Technical Field: Version			NUMBER of record ; Sequence starting from 0',
	CURRENT_FG				SMALLINT		NOT NULL	DEFAULT 1 												COMMENT 'Technical Field 1 indicates the current record in case of several version',
	
	-- TECHNICAL FIELDS 
	REJECT_FG				SMALLINT		NOT NULL	DEFAULT 0 												COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	REJECT_REASON_ID		INTEGER			NOT NULL	DEFAULT -1 												COMMENT 'Link to DQ Reject Reason Codes',
	SOURCE_SYSTEM_ID		INTEGER			NOT NULL	DEFAULT -1 												COMMENT 'Technical Field: Source System. E.g. Manual / Static / PIT Internal / EJR / WAWI / Delivery / ADP',
	DELETED_FG				SMALLINT		NOT NULL	DEFAULT 0 												COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS			TIMESTAMP			NOT NULL	DEFAULT CURRENT_TIMESTAMP() 						COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS			TIMESTAMP		 																	COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID					INTEGER			NOT NULL	DEFAULT 0 												COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (CLIENT_ID, MEDIUM_SID, VALID_FROM_DT, DELETED_FG)
)	
COMMENT='Intially loaded with Medium Static Data and then added with new Media from ADP by daily load'
;

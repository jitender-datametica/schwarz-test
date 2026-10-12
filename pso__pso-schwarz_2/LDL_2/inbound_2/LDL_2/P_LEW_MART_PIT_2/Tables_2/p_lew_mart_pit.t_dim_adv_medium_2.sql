/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for DIM_ADV_MEDIUM
#-------------------------------------------------------------------------------
# Description: Create DDL for dimension holding static+dynamic(adp) medium entries
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-10-01 Aparna Rayanki    Initial version
#  1.1  2022-03-04 Mike Davis        Make SID MD5
#                                    Add MEDIUM_DISPLAY_NAME
#                                    Move name so that it can be processed re. MD5
#  1.2  2022-03-09 Mike Davis        Use SELECT ' section' AS ""
#  1.3  2022-03-23 Mike Davis        Add Coalesce to the md5 calculation
#  1.4  2022-04-01 Mike Davis        Add mstr_sid
#  1.5  2022-04-04 Mike Davis        Adapt to '{MEDIUM_NOT_DEFINED}'
#  1.6  2022-05-02 Mike Davis        Adapt to 'Kein Werbemedium definiert'
#  2.0	2022-07-13 Nikolai Toknov  Changing the script for DevOps
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/
/*
Questions:
    create or replace
    what about create or replace?
   	DEFAULT of 127: maybe higher now?
    do we need a Sonstige medium for each client (see initialize script)?
    If so, should the sort value for this be different from the	DEFAULT?
*/
/*
VC:
MEDIUM_NAME_UPPER
MEDIUM_MSTR_SID

*/
CREATE TABLE P_LEW_MART_PIT.T_DIM_ADV_MEDIUM_2 CLUSTER BY (CLIENT_ID)(

	-- BUSINESS KEY
	CLIENT_ID				INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Client ID e.g. 1=>AT',
	COUNTRY_ISO_CD			VARCHAR(3),
	COUNTRY_DESCR			VARCHAR,
	MEDIUM_NAME				VARCHAR			NOT NULL	DEFAULT 'Sonstige' 							COMMENT '(short) medium name in local language: first version to be found case insensitive (trimmed) - the one displayed',
	MEDIUM_NAME_LDESCR		VARCHAR 																COMMENT 'Concatenate medium name + medium code in local language: for debugging purposes',
	
	-- TECHNICAL KEYS   
	MEDIUM_SID				INTEGER			NOT NULL	DEFAULT -1000 								COMMENT '[Unique system ID, sid, for the medium.',

	-- DATA   
	MEDIUM_SORT_VAL			INTEGER			NOT NULL	DEFAULT 127 								COMMENT 'internal sorting value for the medium',
	MISSING_MEDIUM_FG		SMALLINT		NOT NULL	DEFAULT 0,

	-- Versioning    
	VALID_FROM_DT			DATE			NOT NULL	DEFAULT TO_DATE('1900-01-01', 'YYYY-MM_2-DD') COMMENT 'Technical field Data Historization Valid from ',
	VALID_TO_DT				DATE			NOT NULL	DEFAULT TO_DATE('9999-12-31', 'YYYY-MM_2-DD') COMMENT 'Technical field Data Historization Valid to',
	VERSION_NR				INTEGER			NOT NULL	DEFAULT 0 									COMMENT 'Technical Field: Version NUMBER of record ; Sequence starting from 0',
	CURRENT_FG				SMALLINT		NOT NULL	DEFAULT 1 									COMMENT 'Technical Field 1 indicates the current record in case of several version',

	-- TECHNICAL FIELDS  
    REJECT_FG				SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	REJECT_REASON_ID		INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Link to DQ Reject Reason Codes',
	SOURCE_SYSTEM_ID		INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Technical Field: Source System. E.g. Manual / Static / PIT Internal / EJR / WAWI / Delivery / ADP',
	DELETED_FG				SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS			TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP()					COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS			TIMESTAMP		 														COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID					INTEGER			NOT NULL	DEFAULT 0 									COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (CLIENT_ID, MEDIUM_SID, VALID_FROM_DT, DELETED_FG)
)	COMMENT='Intially loaded with Medium Static Data and then added with new Media from ADP by daily load'
;
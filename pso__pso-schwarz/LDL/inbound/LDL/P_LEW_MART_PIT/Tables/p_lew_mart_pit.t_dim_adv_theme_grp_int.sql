/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for DIM_ADV_THEME_GRP_INT
#-------------------------------------------------------------------------------
# Description: Create DDL for dimension holding static+dynamic(adp) medium entries
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-06-28 Nikolai Toknov	Create the script
#  2.0	2022-05-17 Nikolai Toknov	Change table from DIM_ADV_THEME_GRP to DIM_ADV_THEME_INT_GRP
#  2.1  2023-09-06 Andreas Kurz 	Changes INT/NAT. Release v.5.15. B-0011293A-AP0186978 Anpassung Mapping INT / NAT aus APT
#									Changed Default Value and technical fields
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/
/*
VC:
THEME_GRP_INT_MSTR_SID
*/
CREATE TABLE P_LEW_MART_PIT.T_DIM_ADV_THEME_GRP_INT CLUSTER BY (CLIENT_ID)(
	CLIENT_ID					INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Client ID e.g. 1=>AT',
	COUNTRY_ISO_CD				VARCHAR(3)		NOT NULL 												COMMENT 'Country code corresponding to the client.',
	COUNTRY_DESCR				VARCHAR			NOT NULL 												COMMENT 'Country description corresponding to the client.',

	THEME_GRP_INT_SID			INTEGER			NOT NULL	DEFAULT -1000 								COMMENT 'Unique system ID, sid, for the theme.',
	THEME_GRP_INT_NAME			VARCHAR			NOT NULL	DEFAULT 'Kein Werbethema definiert (INT)' 	COMMENT '(short) distinct theme name, superset of international',
	THEME_GRP_INT_NAME_UPPER	VARCHAR			NOT NULL	DEFAULT 'KEIN WERBETHEMA DEFINIERT (INT)' 	COMMENT '(short) distinct theme name, superset of internationale: unique version for SID (trimmed and uppercase)',
	THEME_GRP_INT_SORT_VAL		INTEGER			NOT NULL	DEFAULT 127 								COMMENT 'Sort value for theme in front-end.',
    
	-- Versioning 
	VALID_FROM_DT				DATE			NOT NULL	DEFAULT TO_DATE('1900-01-01', 'YYYY-MM-DD') COMMENT 'Technical field Data Historization Valid from ',
	VALID_TO_DT					DATE			NOT NULL	DEFAULT TO_DATE('9999-12-31', 'YYYY-MM-DD') COMMENT 'Technical field Data Historization Valid to',
	VERSION_NR					INTEGER			NOT NULL	DEFAULT 0 									COMMENT 'Technical Field: Version			NUMBER of record ; Sequence starting from 0',
	CURRENT_FG					SMALLINT		NOT NULL	DEFAULT 1 									COMMENT 'Technical Field: 1 indicates the current record in case of several version',

	-- technical fields
	REJECT_FG					SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	REJECT_REASON_ID			INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Link to DQ Reject Reason Codes',
	SOURCE_SYSTEM_ID			INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Technical Field: Source System. E.g. Manual / Static / PIT Internal / EJR / WAWI / Delivery / ADP',
	DELETED_FG					SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS				TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP() 				COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS				TIMESTAMP		 														COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID						INTEGER			NOT NULL	DEFAULT 0 									COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (CLIENT_ID, THEME_GRP_INT_SID, VALID_FROM_DT, DELETED_FG)
)	COMMENT='Loaded with some static data (Kein Werbethema international definiert and Totals) then all distinct international theme names from ADP'
;
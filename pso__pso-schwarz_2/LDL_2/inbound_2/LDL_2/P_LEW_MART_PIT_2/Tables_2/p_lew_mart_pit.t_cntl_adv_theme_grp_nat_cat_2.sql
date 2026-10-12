/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for CNTL_ADV_THEME_GRP_NAT_CAT
#-------------------------------------------------------------------------------
# Description: Create DDL for mapping table SID creation theme_nat_cat
#			   Thema Categorie National (NAT)
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2023-09-06 Andreas Kurz 	Changes INT/NAT. Release v.5.15. B-0011293A-AP0186978 Anpassung Mapping INT / NAT aus APT
#									Initial Version 
#-------------------------------------------------------------------------------
*/
/*
USE ROLE 		R_LDL_D_PIT_ETL;
--USE DATABASE 	LDL_PRODUCTION_CLONE_PIT;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R51501;
USE SCHEMA 		P_LEW_MART_PIT_2;
USE WAREHOUSE 	WH_LDL_D_PIT_ETL_S;

ALTER TABLE P_LEW_MART_PIT.T_CNTL_ADV_THEME_GRP_NAT_CAT_2
ADD	
NAT_THEME_TXT					VARCHAR			NOT NULL	DEFAULT 'Kein Werbethema Kategorie (NAT) definiert' 	COMMENT '(short) distinct theme name category (NAT), superset of national: unique version for SID (trimmed and uppercase)'
;

COLLATE(NAT_THEME_TXT_UPPER, 'de-ci-pi-ai-trim')
DESC TABLE P_LEW_MART_PIT.T_CNTL_ADV_THEME_GRP_NAT_CAT_2
*/

CREATE TABLE P_LEW_MART_PIT.T_CNTL_ADV_THEME_GRP_NAT_CAT_2 CLUSTER BY (CLIENT_ID)(
	THEME_GRP_NAT_CAT_SID			INTEGER			NOT NULL	DEFAULT -1000 								COMMENT 'Unique system ID, sid, for the theme.',

	-- 4 Mapping Fields to identfy unique 
	CLIENT_ID						INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Client ID e.g. 1=>AT',
	NAT_THEME_TXT					VARCHAR			NOT NULL	DEFAULT 'Kein Werbethema Kategorie (NAT) definiert' 	COMMENT '(short) distinct theme name category (NAT), superset of national: unique version for SID (trimmed and uppercase)',	
	NAT_THEME_TXT_UPPER				VARCHAR			NOT NULL	DEFAULT 'KEIN WERBETHEMA KATEGORIE (NAT) DEFINIERT' 	COMMENT '(short) distinct theme name category (NAT), superset of national: unique version for SID (trimmed and uppercase)',
	CAMPAIGN_ELEM_START_DT			DATE			NOT NULL	DEFAULT TO_DATE('1900-01-01', 'YYYY-MM_2-DD') COMMENT 'Technical field Data Historization Valid from ',
	DELETED_FG						SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	-- Technical Fields
	DWH_CREATED_TS					TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP() 				COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS					TIMESTAMP		 														COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID							INTEGER			NOT NULL	DEFAULT 0 									COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (CLIENT_ID, NAT_THEME_TXT_UPPER, CAMPAIGN_ELEM_START_DT, DELETED_FG)
)	COMMENT='Control table for generating theme-grp_nat_cat sid'
;
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
#  1.0  2023-09-06 Andreas Kurz 	Changes INTEGER /NAT. Release v.5.15. B-0011293A-AP0186978 Anpassung Mapping INTEGER  / NAT aus APT
#									Initial Version 
#-------------------------------------------------------------------------------
*/
/*
USE ROLE 		R_LDL_D_PIT_ETL;
--USE DATABASE 	LDL_PRODUCTION_CLONE_PIT;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R51501;
USE SCHEMA 		P_LEW_MART_PIT_2;
USE WAREHOUSE 	WH_LDL_D_PIT_ETL_S;

ALTER TABLE LDL.P_LEW_MART_PIT.T_CNTL_ADV_THEME_GRP_NAT_CAT_2
ADD	
NAT_THEME_TXT					STRING			NOT NULL	DEFAULT 'Kein Werbethema Kategorie (NAT) definiert' 	COMMENT '(short) distinct theme name category (NAT), superset of national: unique version for SID (trimmed and uppercase)'


COLLATE(NAT_THEME_TXT_UPPER, 'de-ci-pi-ai-trim')
DESC TABLE P_LEW_MART_PIT.T_CNTL_ADV_THEME_GRP_NAT_CAT_2
*/


-- 4 Mapping Fields to identfy unique
 -- Technical Fields
 CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit.t_cntl_adv_theme_grp_nat_cat_2
(
theme_grp_nat_cat_sid INTEGER DEFAULT - 1000 NOT NULL OPTIONS(description='Unique system ID, sid, for the theme.'),
client_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Client ID e.g. 1=>AT'),
nat_theme_txt STRING(16777216) DEFAULT 'Kein Werbethema Kategorie (NAT) definiert' NOT NULL
OPTIONS(description='(short) distinct theme name category (NAT), superset of national: unique version for SID (trimmed and uppercase)'),
nat_theme_txt_upper STRING(16777216) DEFAULT 'KEIN WERBETHEMA KATEGORIE (NAT) DEFINIERT' NOT NULL
OPTIONS(description='(short) distinct theme name category (NAT), superset of national: unique version for SID (trimmed and uppercase)'),
campaign_elem_start_dt DATE DEFAULT DATE '1900-01-01' NOT NULL
OPTIONS(description='Technical field Data Historization Valid from '),
deleted_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Logical Deleted Flag; indicates if the record was logically deleted'),
dwh_created_ts DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL
OPTIONS(description='Timestamp when record was created'),
dwh_updated_ts DATETIME OPTIONS(description='Technical field timestamp when record was updated'),
load_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Technical Field ELT / ABInitio Process ID'),
PRIMARY KEY (client_id, nat_theme_txt_upper, campaign_elem_start_dt, deleted_fg) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='Control table for generating theme-grp_nat_cat sid');
/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2023
#-------------------------------------------------------------------------------
# Interface : View for AGG_DRILL_THEME
#-------------------------------------------------------------------------------
# Describtion: Create Frontend View for AGG_DRILL_THEME
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2023-01-17 Andreas Kurz	    Initial version
#  1.1  2023-01-30 Andreas Kurz		Added Action Type ID
#  1.2  2023-06-29 K Lukaszewska	Testing cube information added
#  1.3  2023-07-12 Prasanna Ranjan  Removed CUBE_PARTITION_KEY
#  3.0	2023-06-26 Nikolai Toknov	INT/NAT. Release v.5.15. AP0100400_BS0011293_PIT_REPORTING_ADV_THEMA_NAT/INT - Promotion Impact Tracker - IT-Documentation (itdoc.schwarz)
#  3.1  2023-07-28 Nikolai Toknov	Rollback WA
#  3.2  2023-09-13 K Lukaszewska	Changes INT/NAT. Release v.5.15. B-0011293A-AP0186978 Anpassung Mapping INT / NAT aus APT
#									Adding THEME_GRP_CAT Columns
#  4.0 2024-06-19 K Lukaszewska	Column DRILL_TO_ITEMS_LINK_HTML_FILIAL added
#  4.1  2025-02-10 Andreas Kurz		Reworked Structure based on Increment PV 2.1 business requirements (FE-MSTR)
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R51501;
--USE DATABASE	LDL_PRODUCTION_CLONE_PIT_CLONE_AP0123442_AKTIONSTYPEN;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 

-- LDL_PRODUCTION_CLONE_PIT_CLONE_AP0123442_AKTIONSTYPEN.P_LEW_FE_MSTR_PIT
--SHOW DATABASES LIKE 'LDL_PRODUCTION_CLONE_PIT%';
--SELECT GET_DDL('view','P_LEW_FE_MSTR_PIT.V_AGG_DRILL_THEME_1');
*/

/* 
---------------------------------------------------------------------
Create Access View p_lew_fe_mstr_pit.v_agg_drill_theme_1 
------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_FE_MSTR_PIT.V_AGG_DRILL_THEME_1
COMMENT = 'View Dimension AGG_DRILL_THEME'
(
	  CLIENT_ID
	, COUNTRY_ISO_CD
	, COUNTRY_DESCR
	, WAREHOUSE_SID
	, WAREHOUSE_MSTR_SID
	, WAREHOUSE_NAME
	, ORIG_WH_NR
	, ADV_WEEK_ID
	, ADV_WEEK_MSTR_ID
	, REPORTING_LINE_SID
	, REPORTING_LINE_DESCR

	, THEME_GRP_TYPE_ID		
--	, FE_MSTR_RELEVANT_FG		
	, THEME_GRP_TYPE_SORT_VAL	
	, THEME_GRP_TYPE_NAME		
	, THEME_GRP_TYPE_DESCR	

	, THEME_GRP_INT_SID
	, THEME_GRP_INT_MSTR_SID
		
	, THEME_GRP_INT_NAME		
	, THEME_GRP_INT_SORT_VAL	

	, THEME_GRP_NAT_SID
	, THEME_GRP_NAT_MSTR_SID
	
	, THEME_GRP_NAT_NAME		
	, THEME_GRP_NAT_SORT_VAL
	
	, THEME_GRP_NAT_CAT_SID
	, THEME_GRP_NAT_CAT_MSTR_SID
	
	, THEME_GRP_NAT_CAT_NAME		
	, THEME_GRP_NAT_CAT_SORT_VAL

	, THEME_GRP_MAIN_MSTR_SID 
	, THEME_GRP_MAIN_NAME
	
	, DRILL_TO_ITEMS_LINK_HTML
	--, DRILL_TO_ITEMS_LINK_HTML_FILIAL
	, DRILL_TO_HIST_LINK_HTML
	, REJECT_FG
	, REJECT_REASON_ID
	, SOURCE_SYSTEM_ID
	, DELETED_FG
	, DWH_CREATED_TS
	, DWH_UPDATED_TS
	, LOAD_ID
	, WAREHOUSE_GID
	, WAREHOUSE_MSTR_GID								
	-- 2023-01-30 Added Action Type ID
	, ACTION_TYPE_ID

	-- Add old columns on THEME GRP @tobedeleted
	, THEME_GRP_NAME
	, THEME_GRP_MSTR_SID
	, THEME_GRP_SID	
)
AS
SELECT
	  agg.CLIENT_ID
	, agg.COUNTRY_ISO_CD
	, agg.COUNTRY_DESCR
	, agg.WAREHOUSE_SID
	, agg.WAREHOUSE_MSTR_SID
	, agg.WAREHOUSE_NAME
	, agg.ORIG_WH_NR
	, agg.ADV_WEEK_ID
	, agg.ADV_WEEK_MSTR_ID
	, agg.REPORTING_LINE_SID
	, agg.REPORTING_LINE_DESCR

	, agg.THEME_GRP_TYPE_ID		
--	, agg.FE_MSTR_RELEVANT_FG		
	, agg.THEME_GRP_TYPE_SORT_VAL	
	, agg.THEME_GRP_TYPE_NAME		
	, agg.THEME_GRP_TYPE_DESCR	

	--, TRY_TO_NUMBER (LEFT(TO_CHAR(agg.THEME_GRP_INT_SID),2) || RIGHT(TO_CHAR(agg.THEME_GRP_INT_SID),10) ) AS _THEME_GRP_INT_SID
	, agg.THEME_GRP_INT_SID
	--, _THEME_GRP_INT_SID * 100::INTEGER + CLIENT_ID AS THEME_GRP_INT_MSTR_SID
	, agg.THEME_GRP_INT_MSTR_SID
		
	, agg.THEME_GRP_INT_NAME		
	, NULL::INTEGER AS THEME_GRP_INT_SORT_VAL	

	--, TRY_TO_NUMBER( LEFT(TO_CHAR(agg.THEME_GRP_NAT_SID),2) || RIGHT(TO_CHAR(agg.THEME_GRP_NAT_SID),10) ) AS _THEME_GRP_NAT_SID
	, agg.THEME_GRP_NAT_SID
	--, _THEME_GRP_NAT_SID * 100::INTEGER + CLIENT_ID AS THEME_GRP_NAT_MSTR_SID
	, agg.THEME_GRP_NAT_MSTR_SID
	
	, agg.THEME_GRP_NAT_NAME		
	, NULL::INTEGER AS  THEME_GRP_NAT_SORT_VAL	
	
	, agg.THEME_GRP_NAT_CAT_SID
	, agg.THEME_GRP_NAT_CAT_MSTR_SID
	, agg.THEME_GRP_NAT_CAT_NAME		
	, NULL::INTEGER AS  THEME_GRP_NAT_CAT_SORT_VAL

	-- TRY_TO_NUMBER( LEFT(TO_CHAR(agg.THEME_GRP_MAIN_MSTR_SID),2) || RIGHT(TO_CHAR(agg.THEME_GRP_MAIN_MSTR_SID),10) ) AS THEME_GRP_MAIN_MSTR_SID 
	, agg.THEME_GRP_MAIN_MSTR_SID
	, agg.THEME_GRP_MAIN_NAME
	
	, agg.DRILL_TO_ITEMS_LINK_HTML
	--, agg.DRILL_TO_ITEMS_LINK_HTML_FILIAL
	, agg.DRILL_TO_HIST_LINK_HTML
	, agg.REJECT_FG
	, agg.REJECT_REASON_ID
	, agg.SOURCE_SYSTEM_ID
	, agg.DELETED_FG
	, agg.DWH_CREATED_TS
	, agg.DWH_UPDATED_TS
	, agg.LOAD_ID
	, agg.WAREHOUSE_GID
	, agg.WAREHOUSE_MSTR_GID								
	-- 2023-01-30 Added Action Type ID
	, agg.ACTION_TYPE_ID		
	
	-- Add old columns on THEME GRP @tobedeleted
	, NULL::VARCHAR 		AS THEME_GRP_NAME
	, NULL::INTEGER 		AS THEME_GRP_MSTR_SID
	, NULL::INTEGER			AS THEME_GRP_SID 
FROM P_LEW_FE_MSTR_PIT.T_AGG_DRILL_THEME_1 agg
WHERE TRUE
	AND agg.DELETED_FG 	= 0
	AND agg.REJECT_FG	= 0
;	

--SELECT * FROM P_LEW_FE_MSTR_PIT.V_AGG_DRILL_THEME_1 WHERE CLIENT_ID = 32 AND THEME_GRP_TYPE_ID = 3 AND THEME_GRP_NAT_CAT_SID > 0 LIMIT 100;
-- SELECT * FROM p_lew_fe_mstr_pit.v_dim_adv_theme_grp_type_1
--DESC TABLE P_LEW_FE_MSTR_PIT.T_AGG_REGION_THEME_ALL_1

/* --- EOF - END OF FILE --- */

/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2023
#-------------------------------------------------------------------------------
# Interface : View for AGG_DRILL_ITEM
#-------------------------------------------------------------------------------
# Describtion: Create Frontend View for AGG_DRILL_ITEM
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2023-01-17 Andreas Kurz	    Initial version
#  1.1  2023-06-29 K Lukaszewska	Testing cube information added
#  1.2  2023-07-12 Prasanna Ranjan  Removed CUBE_PARTITION_KEY
#  1.6  2025-02-10 Andreas Kurz		Reworked Structure based on Increment PV 2.1 business requirements (FE-MSTR)
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT;
--USE DATABASE	LDL_PRODUCTION_CLONE_PIT_CLONE_AP0123442_AKTIONSTYPEN;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 

-- LDL_PRODUCTION_CLONE_PIT_CLONE_AP0123442_AKTIONSTYPEN.P_LEW_FE_MSTR_PIT
--SHOW DATABASES LIKE 'LDL_PRODUCTION_CLONE_PIT%';
--SELECT GET_DDL('view','P_LEW_FE_MSTR_PIT.V_AGG_DRILL_ITEM_2');
*/

/* 
---------------------------------------------------------------------
Create Access View p_lew_fe_mstr_pit.v_agg_drill_item_2 
------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_FE_MSTR_PIT.V_AGG_DRILL_ITEM_2
COMMENT = 'View Dimension AGG_DRILL_ITEM'
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
	, agg.ORIG_ITEM_NR
	, agg.ORIG_ITEM_MSTR_NR
	, agg.ITEM_INT_DESCR
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
	, agg.ORIG_ITEM_GID
	, agg.ORIG_ITEM_MSTR_GID	
FROM P_LEW_FE_MSTR_PIT.T_AGG_DRILL_ITEM_2 agg
WHERE TRUE
	AND agg.DELETED_FG 	= 0
	AND agg.REJECT_FG	= 0
;	

--SELECT * FROM P_LEW_FE_MSTR_PIT.V_AGG_DRILL_ITEM_2 LIMIT 1;


/* --- EOF - END OF FILE --- */

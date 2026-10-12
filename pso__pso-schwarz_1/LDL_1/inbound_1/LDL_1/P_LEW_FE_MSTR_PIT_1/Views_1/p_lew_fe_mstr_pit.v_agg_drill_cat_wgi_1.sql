/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2023
#-------------------------------------------------------------------------------
# Interface : View for AGG_DRILL_CAT_WGI
#-------------------------------------------------------------------------------
# Describtion: Create Frontend View for AGG_DRILL_CAT_WGI
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2023-01-17 Andreas Kurz	    Initial version
#  1.1  2023-01-30 Andreas Kurz		Added Action Type ID
#  1.2  2023-06-29 K Lukaszewska	Testing cube information added
#  1.3  2023-07-12 Prasanna Ranjan  Added CUBE_PARTITION_KEY
#  1.4  2023-10-09 Nikolai Toknov	Cosmetic changes
#  1.5	2024-07-08 K Lukaszewska	Column DRILL_TO_UWGS_LINK_HTML_FILIAL added
#  1.6  2025-02-10 Andreas Kurz		Reworked Structure based on Increment PV 2.1 business requirements (FE-MSTR)
#  1.7  2025-02-13 Andreas Kurz		CUBE_PARTITION_KEY removed
#  1.8  2025-04-07 Andreas Kurz		CUBE_PARTITION_KEY Added
#-------------------------------------------------------------------------------
*/

/* 
---------------------------------------------------------------------
Create Access View p_lew_fe_mstr_pit.v_agg_drill_cat_wgi_1 
------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_FE_MSTR_PIT.V_AGG_DRILL_CAT_WGI_1
COMMENT = 'View Dimension AGG_DRILL_CAT_WGI'
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
--	, agg.RLTD_ADV_WEEK_ID
--	, agg.RLTD_ADV_WEEK_MSTR_ID
	, agg.REPORTING_LINE_SID
	, agg.REPORTING_LINE_DESCR
	, agg.ITEM_GRP_INT_SID
	, agg.ITEM_GRP_INT_MSTR_SID
	, agg.ITEM_GRP_INT_SRC_CD
	, agg.ITEM_GRP_INT_NAME
	, agg.DRILL_TO_UWGS_LINK_HTML
	--, agg.DRILL_TO_UWGS_LINK_HTML_FILIAL
	, agg.REJECT_FG
	, agg.REJECT_REASON_ID
	, agg.SOURCE_SYSTEM_ID
	, agg.DELETED_FG
	, agg.DWH_CREATED_TS
	, agg.DWH_UPDATED_TS
	, agg.LOAD_ID
	, agg.WAREHOUSE_GID
	, agg.WAREHOUSE_MSTR_GID
	, agg.ITEM_GRP_INT_GID
	, agg.ITEM_GRP_INT_MSTR_GID	
	-- 2023-01-30 Added Action Type ID
	, agg.ACTION_TYPE_ID		
	, ROW_NUMBER()OVER (PARTITION BY NULL ORDER BY NULL) AS CUBE_PARTITION_KEY
FROM P_LEW_FE_MSTR_PIT.T_AGG_DRILL_CAT_WGI_1 agg
WHERE TRUE
	AND agg.DELETED_FG 	= 0
	AND agg.REJECT_FG	= 0
;
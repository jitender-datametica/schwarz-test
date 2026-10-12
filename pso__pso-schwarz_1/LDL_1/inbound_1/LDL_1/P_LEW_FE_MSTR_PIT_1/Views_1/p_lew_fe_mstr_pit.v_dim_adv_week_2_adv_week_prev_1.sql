/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2023
#-------------------------------------------------------------------------------
# Interface : View for T_DIM_ADV_WEEK_2_ADV_WEEK_PREV_1
#-------------------------------------------------------------------------------
# Describtion: Create Frontend View for T_DIM_ADV_WEEK_2_ADV_WEEK_PREV_1
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2023-01-17 Andreas Kurz	    Initial version
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
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
--SELECT GET_DDL('view','P_LEW_FE_MSTR_PIT.V_DIM_ADV_WEEK_2_ADV_WEEK_PREV_1');
--DESC VIEW LDL_PRODUCTION_CLONE_PIT_CLONE_AP0123442_AKTIONSTYPEN.P_LEW_FE_MSTR_PIT.V_DIM_ADV_WEEK_2_ADV_WEEK_PREV_1;
--DESC TABLE LDL_PRODUCTION_CLONE_PIT_CLONE_AP0123442_AKTIONSTYPEN.P_LEW_FE_MSTR_PIT.T_DIM_ADV_WEEK_2_ADV_WEEK_PREV_1;
--DESC TABLE LDL_PRODUCTION_CLONE_PIT.P_LEW_FE_MSTR_PIT.V_DIM_ADV_THEME_GRP;
--SELECT * FROM LDL_PRODUCTION_CLONE_PIT.P_LEW_FE_MSTR_PIT.V_DIM_ADV_THEME_GRP LIMIT 1;
*/

/* 
---------------------------------------------------------------------
Create Access View p_lew_fe_mstr_pit.v_dim_adv_week_2_adv_week_prev_1 
------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_FE_MSTR_PIT.V_DIM_ADV_WEEK_2_ADV_WEEK_PREV_1
COMMENT = 'View Dimension DIM_ADV_WEEK_2_ADV_WEEK_PREV'
AS
SELECT
	  agg.CLIENT_ID
	, agg.COUNTRY_ISO_CD
	, agg.COUNTRY_DESCR
	, agg.ADV_WEEK_ID
	, (agg.ADV_WEEK_ID * 100) + CLIENT_ID AS ADV_WEEK_MSTR_ID
	,  TRIM(
			 (TO_CHAR((agg.ADV_WEEK_ID % 100) , '09')) 
			 || '/' 
			 || (CAST(TRY_CAST(SUBSTRING(CAST(agg.ADV_WEEK_ID AS VARCHAR)
						, 1
						, 4
						) 
				AS INTEGER) AS VARCHAR))
	   )   AS ADV_WEEK_DESCR
	, agg.RLTD_ADV_WEEK_ID
	, (agg.RLTD_ADV_WEEK_ID * 100) + CLIENT_ID AS RLTD_ADV_WEEK_MSTR_ID
	, TRIM(
			 (TO_CHAR((agg.RLTD_ADV_WEEK_ID % 100) , '09')) 
			 || '/' 
			 || (CAST(TRY_CAST(SUBSTRING(CAST(agg.RLTD_ADV_WEEK_ID AS VARCHAR)
						, 1
						, 4
						) 
				AS INTEGER) AS VARCHAR))
	   ) AS RLTD_ADV_WEEK_DESCR
	--, agg.RLTD_ADV_WEEK_SDESCR
	--, agg.RLTD_ADV_WEEK_LDESCR
	, agg.RLTD_ADV_WEEK_START_DT
	, agg.RLTD_ADV_WEEK_END_DT
	, agg.DIFF_ADV_WEEK_NR
	, agg.NEAREST_RLTD_ADV_WEEK_FG
	, agg.RELATED_TYPE_ID
	, agg.RELATED_TYPE_DESCR
	, agg.REJECT_FG
	, agg.REJECT_REASON_ID
	, agg.SOURCE_SYSTEM_ID
	, agg.DELETED_FG
	, agg.DWH_CREATED_TS
	, agg.DWH_UPDATED_TS
	, agg.LOAD_ID										
FROM P_LEW_FE_MSTR_PIT.T_DIM_ADV_WEEK_2_ADV_WEEK_PREV_1 agg
WHERE TRUE
	AND agg.DELETED_FG 	= 0
	AND agg.REJECT_FG	= 0
;	

--SELECT * FROM P_LEW_FE_MSTR_PIT.V_DIM_ADV_WEEK_2_ADV_WEEK_PREV_1 LIMIT 1;


/* --- EOF - END OF FILE --- */

/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2023
#-------------------------------------------------------------------------------
# Interface : View for AGG_REGION_THEME_ALL
#-------------------------------------------------------------------------------
# Describtion: Create Frontend View for AGG_REGION_THEME_ALL
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2023-01-17 Andreas Kurz	    Initial version
#  1.1  2023-01-30 Andreas Kurz		Added
#										 ACTION_TYPE_ID
#										 ACTION_TYPE_SORT_VAL
#										 ACTION_TYPE_NAME
#										 ACTION_TYPE_DESCR
#  1.2  2023-06-29 K Lukaszewska	Testing cube information added
#  3.0	2023-06-26 Nikolai Toknov	INT/NAT. Release v.5.15. AP0100400_BS0011293_PIT_REPORTING_ADV_THEMA_NAT/INT - Promotion Impact Tracker - IT-Documentation (itdoc.schwarz) 
#  3.1  2023-07-28 Nikolai Toknov	Rollback WA
#  3.2  2023-09-12 K Lukaszewska	Category columns added for INT/NAT
#  4.0	2024-02-12 K Lukaszewska	Join to T_DIM_ADV_WEEK_2_ADV_WEEK_PREV_2 for Related Adv Week data
#  4.1  2024-02-14 Prasanna Ranjan	Added new columns for PIT Increment 2 (PV)
#  4.2  2024-03-25 Nikolai Toknov	Chnage table T_DIM_ADV_WEEK_2_ADV_WEEK_PREV_2 to view 
#  4.3	2024-07-19 K Lukaszewska	Added missing columns for PIT Increment 2 (PV)
#  4.4  2024-09-24 Prasanna Ranjan	Adjustment Increment 2.1 (PV)
#-------------------------------------------------------------------------------
*/

/*
USE ROLE 		R_LDL_D_PIT_ETL;
--USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R51501;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R60001;
USE SCHEMA 		P_LEW_MART_PIT_2;
USE WAREHOUSE 	WH_LDL_D_PIT_ETL_S; 

 */

/*
---------------------------------------------------------------------
Create Access View p_lew_fe_mstr_pit.v_agg_region_theme_all_2
------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_FE_MSTR_PIT.V_AGG_REGION_THEME_ALL_2
COMMENT = 'View Dimension AGG_REGION_THEME_ALL'
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
	, agg.ADV_WEEK_START_DT
	, agg.ADV_WEEK_END_DT
	, agg.ADV_WEEK_START_DT_DESCR
	, agg.ADV_WEEK_END_DT_DESCR
	, agg.ADV_WEEK_START_DAY_SDESCR
	, agg.ADV_WEEK_END_DAY_SDESCR
	, agg.ADV_WEEK_START_DAY_DESCR
	, agg.ADV_WEEK_END_DAY_DESCR
	, agg.LENGTH_OF_ADV_WEEK
	, agg.ADV_WEEK_YEAR_ID
	, agg.ADV_WEEK_WEEK_NR
	, agg.ADV_WEEK_SDESCR
	, agg.ADV_WEEK_DESCR
	, agg.ADV_WEEK_LDESCR
	, agg.ADV_WEEK_OVERLAP_LDESCR
	, agg.PREV_1_ADV_WEEK_ID
	, agg.NEXT_1_ADV_WEEK_ID
	, agg.PREV_1_YEAR_ADV_WEEK_ID
	, agg.LAST_ADV_WEEK_FG
	, agg.LAST_CLOSED_ADV_WEEK_FG
	, agg.MOV_ADV_WEEK_START_FROM_CURRENT
	, agg.MAX_ADV_PERIOD_END_DT
	, agg.REPORTING_LINE_SID
	, agg.REPORTING_LINE_DESCR
	
		--Related Adv Week data
	, NULL AS RLTD_ADV_WEEK_ID
	, NULL AS RLTD_ADV_WEEK_MSTR_ID
	, NULL AS RLTD_ADV_WEEK_SDESCR
	, NULL AS RLTD_ADV_WEEK_DESCR
	, NULL AS RLTD_ADV_WEEK_LDESCR
	
	-- AKU 2023-07-11
	, -2000::INTEGER 							AS THEME_GRP_SID
	, ((-2000 * 100) - agg.CLIENT_ID)::INTEGER 	AS THEME_GRP_MSTR_SID
	, 'Gesamt' 									AS THEME_GRP_NAME
	, 200000::INTEGER 							AS THEME_GRP_SORT_VAL
	
	, agg.THEME_GRP_TYPE_ID		
--	, agg.FE_MSTR_RELEVANT_FG		
	, agg.THEME_GRP_TYPE_SORT_VAL	
	, agg.THEME_GRP_TYPE_NAME		
	, agg.THEME_GRP_TYPE_DESCR	
						
	-- TRY_TO_NUMBER (LEFT(TO_CHAR(agg.THEME_GRP_INT_SID),2) || RIGHT(TO_CHAR(agg.THEME_GRP_INT_SID),10) ) AS _THEME_GRP_INT_SID
	, agg.THEME_GRP_INT_SID
	-- _THEME_GRP_INT_SID * 100::INTEGER + CLIENT_ID AS THEME_GRP_INT_MSTR_SID
	, agg.THEME_GRP_INT_MSTR_SID
	, agg.THEME_GRP_INT_NAME		
	, agg.THEME_GRP_INT_SORT_VAL	
						
	-- TRY_TO_NUMBER( LEFT(TO_CHAR(agg.THEME_GRP_NAT_SID),2) || RIGHT(TO_CHAR(agg.THEME_GRP_NAT_SID),10) ) AS _THEME_GRP_NAT_SID
	, agg.THEME_GRP_NAT_SID
	-- _THEME_GRP_NAT_SID * 100::INTEGER + CLIENT_ID AS THEME_GRP_NAT_MSTR_SID
	, agg.THEME_GRP_NAT_MSTR_SID
	, agg.THEME_GRP_NAT_NAME	
	, agg.THEME_GRP_NAT_SORT_VAL	
	
	, agg.THEME_GRP_NAT_CAT_SID		
	, agg.THEME_GRP_NAT_CAT_MSTR_SID	
	, agg.THEME_GRP_NAT_CAT_NAME	
	, agg.THEME_GRP_NAT_CAT_SORT_VAL
	
	-- TRY_TO_NUMBER( LEFT(TO_CHAR(agg.THEME_GRP_MAIN_MSTR_SID),2) || RIGHT(TO_CHAR(agg.THEME_GRP_MAIN_MSTR_SID),10) ) AS THEME_GRP_MAIN_MSTR_SID
	, agg.THEME_GRP_MAIN_MSTR_SID
	, agg.THEME_GRP_MAIN_NAME
	
	-- AKU 2023-01-30 Added Aktionstypen ID Columns	
	, agg.ACTION_TYPE_ID
	, agg.ACTION_TYPE_NAME
	, agg.ACTION_TYPE_DESCR
	, agg.ACTION_TYPE_SORT_VAL


	, agg.SORT_ORDER_VAL
	-- Facts
	
	, agg.ADD_TURNOVER_NET_VAL
	, agg.ADD_TURNOVER_NET_PER_STORE_VAL
	, agg.ADD_TURNOVER_QTY
	, agg.ADD_TURNOVER_PER_STORE_QTY
	, agg.ADD_TURNOVER_REVENUE_NET_VAL
	, agg.ADD_TURNOVER_REVENUE_NET_PER_STORE_VAL
	, agg.ADD_RECEIPT_CNT
	, agg.ADD_RECEIPT_PER_STORE_CNT
	, agg.ADV_ITEM_CNT
	, agg.ADV_ITEM_FA_CNT
	, agg.ADV_ITEM_NF_CNT
	, agg.ADV_ITEM_PV_CNT
	, agg.ADV_ITEM_PV_LP_CNT
	, agg.ADV_ITEM_PV_NPPS_CNT
	, agg.ADV_ITEM_PV_WAWI_CNT
	, agg.ADV_RECEIPT_ADV_TURNOVER_NET_VAL
	, agg.ADV_RECEIPT_NP_TURNOVER_NET_VAL
	, agg.ADV_RECEIPT_TOTAL_TURNOVER_NET_VAL
	, agg.BASE_RECEIPT_CNT
	, agg.BASE_TURNOVER_NET_VAL
	, agg.BASE_TURNOVER_REVENUE_NET_VAL
	, agg.BASE_TURNOVER_QTY
	, agg.CHERRY_PICKER_RECEIPT_CNT
	, agg.CHERRY_PICKER_RECEIPT_CNT_PCT
	, agg.HEAVY_BUYER_RECEIPT_CNT
	, agg.HEAVY_BUYER_RECEIPT_CNT_PCT
	, agg.PV_EFFIC_REVENUE_FACTOR
	, agg.PV_EFFIC_TURNOVER_FACTOR
	
	-- AKU 2025-03-31
	, iff( agg.ACTION_TYPE_ID > 10, NULL, agg.PV_NET_VAL)	 			AS PV_NET_VAL
	, iff( agg.ACTION_TYPE_ID > 10, NULL, agg.PV_NET_VAL_SHARE_PCT) 	AS PV_NET_VAL_SHARE_PCT	

	, agg.PV_LP_NET_VAL
	, agg.PV_LP_NET_VAL_SHARE_PCT
	, agg.PV_NPPS_NET_VAL
	, agg.PV_NPPS_NET_VAL_SHARE_PCT
	, agg.PV_WAWI_NET_VAL
	, agg.PV_WAWI_NET_VAL_SHARE_PCT
	, agg.RECEIPT_CNT
	, agg.RECEIPT_CNT_SHARE_PCT
	, agg.RECEIPT_PER_STORE_CNT
	, agg.RESTBON_NP_TURNOVER_NET_VAL
	, agg.RESTBON_TURNOVER_NET_VAL
	, agg.RESTBON_TURNOVER_REVENUE_NET_VAL
	, agg.STORE_CNT
	, agg.TOTAL_RECEIPT_CNT
	, agg.TOTAL_TURNOVER_NET_VAL
	
	--, iff( agg.ACTION_TYPE_ID > 10, NULL, agg.TURNOVER_MARGIN_PCT) AS TURNOVER_MARGIN_PCT 	
	, agg.TURNOVER_MARGIN_PCT	
	, agg.TURNOVER_NET_PER_STORE_VAL
	, agg.TURNOVER_NET_VAL
	, agg.TURNOVER_NET_VAL_SHARE_PCT
	, agg.TURNOVER_QTY

	--, iff( agg.ACTION_TYPE_ID > 10, NULL, agg.TURNOVER_REVENUE_NET_VAL) AS TURNOVER_REVENUE_NET_VAL 		
	, agg.TURNOVER_REVENUE_NET_VAL	
	, agg.TURNOVER_REVENUE_NET_STORE_VAL
	, agg.VOLUME_BUY_NET_VAL
	
	, agg.REJECT_FG
	, agg.REJECT_REASON_ID
	, agg.SOURCE_SYSTEM_ID
	, agg.DELETED_FG
	, agg.DWH_CREATED_TS
	, agg.DWH_UPDATED_TS
	, agg.LOAD_ID
	, agg.WAREHOUSE_GID
	, agg.WAREHOUSE_MSTR_GID
FROM P_LEW_FE_MSTR_PIT.T_AGG_REGION_THEME_ALL_2 agg

/*
-- join to get the Related Adv Week data
INNER JOIN 
		(
		SELECT DISTINCT
		  CLIENT_ID 
		, ADV_WEEK_ID
		, ADV_WEEK_MSTR_ID
		, RLTD_ADV_WEEK_ID
		, NEAREST_RLTD_ADV_WEEK_FG
		, RLTD_ADV_WEEK_MSTR_ID
		, RLTD_ADV_WEEK_SDESCR
		, RLTD_ADV_WEEK_DESCR
		, RLTD_ADV_WEEK_LDESCR
        FROM P_LEW_FE_MSTR_PIT.V_DIM_ADV_WEEK_2_ADV_WEEK_PREV_2
        WHERE TRUE
            -- AND CLIENT_ID               IN (1,2,4,23)               -- List of Clients e.g. 2 or 1,2,3,5 so it could run in ps1 framework and also in ABInitio
			AND DELETED_FG              = 0
            AND REJECT_FG               = 0
		) adv
		ON  agg.CLIENT_ID = adv.CLIENT_ID
		AND agg.ADV_WEEK_ID = adv.ADV_WEEK_ID
		AND agg.ADV_WEEK_MSTR_ID = adv.ADV_WEEK_MSTR_ID
		*/
WHERE TRUE
	AND agg.DELETED_FG 	= 0
	AND agg.REJECT_FG	= 0
;

--SELECT * FROM P_LEW_FE_MSTR_PIT.V_AGG_REGION_THEME_ALL_2 LIMIT 10;


/* --- EOF - END OF FILE --- */



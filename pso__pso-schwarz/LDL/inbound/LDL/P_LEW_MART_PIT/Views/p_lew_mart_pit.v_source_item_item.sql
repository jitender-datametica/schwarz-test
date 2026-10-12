/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : VIEW fOR V_SOURCE_ITEM_ITEM
#-------------------------------------------------------------------------------
# Describtion: CREATE VIEW fOR V_SOURCE_ITEM_ITEM
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-08-16 Massimo Morelli  Initial version
#  1.1  2021-09-07 Mike Davis       Refinement
#  1.2  2021-09-17 Mike Davis       Formatting
#  1.3  2021-09-29 Dirk Hering      Use example role added, data types added, column order, formatting
#  1.4  2021-10-08 Dirk Hering      Added casts to INTEGER for orig_item_nr, case_size; try_to_number for case_size
#  1.5  2021-10-12 Dirk Hering      Deduplication from source (Qualify Row Number = 1); itmh.dwh_updated
#  1.6  2022-02-03 Mike Davis       Change orig_item_nr to number(38,0), case_size to number(38,5)
#  1.7  2022-03-17 Andreas Kurz		Changed ORIG_ITEM_NR (NAN)
#  1.8  2022-06-17 Andreas Kurz		Reowrked entire view
#  1.9  2022-06-21 Andreas Kurz		Added DAT_VALID_FROM_MIGRATED_FG, changed DAT_VALID_FROM in cas of Ex-Elvis Country
#										Added section / case of Ex-Elvis and WAWI items
#  2.2	2022-07-22 Nikolai Toknov  	Changing the script for DevOps
#  2.3	2023-04-26 Nikolai Toknov	Use ITEM_FAM_GRP_SID as AS-IS. WA. The target solution requires changes in architecture and joining at the T_A_*-level
#  2.4	2024-09-23 Nikolai Toknov	Add schema name for f_CleanValidToDate
#-------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW P_LEW_MART_PIT.V_SOURCE_ITEM_ITEM
COMMENT = 'Source View for Core Item (Item SID / Item Variant)'
AS
SELECT
      itm.CLIENT_ID::INTEGER                                                            			AS CLIENT_ID
	, cl.COUNTRY_DESCR																				AS COUNTRY_DESCR
	, cl.COUNTRY_ISO_CD	  																			AS COUNTRY_ISO_CD
    , cl.CTR_EX_ELVIS_COUNTRY_FG																	AS CTR_EX_ELVIS_COUNTRY_FG
			
    , itm.ITEM_SID::INTEGER                                                             			AS ITEM_SID

    --, itms.ITEM_STATUS_CD::VARCHAR																	AS ITEM_STATUS_CD
    --, itms.ITEM_STATUS_FG::SMALLINT																	AS ITEM_STATUS_FG  
    
    --, itms.DAT_REC_START																			AS ITEM_STATUS_START_DT
    --, itms.DAT_REC_END																				AS ITEM_STATUS_END_DT
    
    -- business item keys
    --    Note:
    --    without this Coalesce there are many more Null (-1) orig_item_nr
    --    at some stage we will have to check that the existing active items were properly converted to wawi at the wawi transition date
    --  , try_to_number(COALESCE(itm.src_orig_item_nr, itm.config_item_cd, itm.src_matnr), 38, 0)    AS orig_item_nr
    --
    , itm.ORIG_ITEM_NR																				AS ORIG_ITEM_NR
	, iff(ORIG_ITEM_NR<0
		,(ORIG_ITEM_NR * 100::INTEGER ) - itm.CLIENT_ID
		,(ORIG_ITEM_NR * 100::INTEGER ) + itm.CLIENT_ID
        )																							AS ORIG_ITEM_MSTR_NR
    , itm.CASE_SIZE               																	AS CASE_SIZE                 	-- @check there is no -1 in the data (not checked yet)
    , COALESCE(itm.SRC_DAT_VALID_FROM::DATE, cl.CTR_EX_ELVIS_COUNTRY_MIGRATION_DATE_TO + 1)   		AS DAT_VALID_FROM			 	-- Geburtsdatum
	
	, iff(itm.SRC_DAT_VALID_FROM::DATE IS NULL, 1::SMALLINT, 0::SMALLINT) 							AS DAT_VALID_FROM_MIGRATED_FG	-- Indicator / Flag to show if Geburtsdatum is artifical																					
    -- item information                                                                 
    , COALESCE(itm.ITEM_NAME       , itmd_i.ITEM_DESCR   , itmd_l.ITEM_DESCR   , 'n/A')::VARCHAR   	AS ITEM_NAME
    , COALESCE(itmd_l.ITEM_DESCR   , itm.ITEM_NAME       , itmd_i.ITEM_DESCR   , 'n/A')::VARCHAR   	AS ITEM_DESCR
    , COALESCE(itmd_i.ITEM_DESCR   , itmd_l.ITEM_DESCR   , itm.ITEM_NAME       , 'n/A')::VARCHAR   	AS ITEM_INT_DESCR
																				
	, iff(
		-- Wawi Countries with Wawi items
		(
			TRUE
			AND cl.CTR_EX_ELVIS_COUNTRY_FG 	= 0 
			AND LOWER(TRIM(ITEM_NAME)) 		LIKE 'mainitem%'
		)
			OR
		-- Ex-Elvis Countries with SAP items
		(
			TRUE
			AND cl.CTR_EX_ELVIS_COUNTRY_FG = 1 		
			AND 
			(
			itm.LOG_VAR_CD = '1' 
				OR
			itm.LOG_VAR_CD IS NULL
			)
			AND itm.SRC_MATNR 		IS NOT NULL -- SAP Item
			AND itm.SRC_MATNR 		NOT LIKE '@%'
			AND itm.CONFIG_ITEM_CD 	IS NULL
		) 
			OR
		-- Ex-Elvis Countries with WAWI items
		(
			TRUE
			AND cl.CTR_EX_ELVIS_COUNTRY_FG 	= 1 	
			AND LOWER(TRIM(ITEM_NAME)) 		LIKE 'mainitem%'
		)
		, 1::SMALLINT
		, 0::SMALLINT
		)																							AS MAIN_ITEM_FG
																						
    -- additional item hierarchy join fields                                            
    , COALESCE(itmh.ITEM_FAM_GRP_SID, -1000)::INTEGER                                  				AS ITEM_FAM_GRP_SID
    , COALESCE(itmh.BRAND_SID, -1000)::INTEGER                                         				AS BRAND_SID
																						
    -- technical versioning                                                             
    , COALESCE(itmh.DWH_VALID_FROM, '1900-01-01'::DATE)::DATE                       				AS VALID_FROM_DT
    , P_LEW_MART_PIT.f_CleanValidToDate(itmh.DWH_VALID_TO)::DATE                                   				AS VALID_TO_DT
																										
	, itmh.DELETED_FG::SMALLINT                                                     				AS DELETED_FG
    , itmh.DWH_UPDATED::TIMESTAMP                                                   				AS DWH_UPDATED_TS

FROM
    (
        SELECT
			  itm.CLIENT_ID	  
			, itm.ITEM_SID
			, itm.SRC_ORIG_ITEM_NR
			, itm.CONFIG_ITEM_CD
			, itm.SRC_MATNR
			, itm.LOG_VAR_CD
			--, COALESCE(TRY_TO_NUMBER(itm.SRC_ORIG_ITEM_NR), TRY_TO_NUMBER(itm.CONFIG_ITEM_CD), TRY_TO_NUMBER(REGEXP_REPLACE(itm.SRC_MATNR, '(_|[A-z])','') ),-1000)::NUMBER(38,0)
			, COALESCE(TRY_TO_NUMBER(itm.SRC_ORIG_ITEM_NR), TRY_TO_NUMBER(itm.CONFIG_ITEM_CD), TRY_TO_NUMBER(itm.SRC_MATNR),-1000)::NUMBER(38,0)			
																								AS ORIG_ITEM_NR
			, try_to_number(itm.SRC_CASE_SIZE)::NUMBER(38,5)               						AS CASE_SIZE		
			, itm.SRC_DAT_VALID_FROM															AS SRC_DAT_VALID_FROM			 -- Geburtsdatum, if empty --> Migration Date
			, itm.ITEM_NAME																		AS ITEM_NAME

        FROM P_LEW_CORE.T_ITEM itm
		WHERE TRUE
			-- Exclude negative NANs and Item Sids
			AND ORIG_ITEM_NR 		> 0
			AND itm.ITEM_SID 		> 0
			
			AND itm.CLIENT_ID IN (
				-- PIT Country
				SELECT 
					CLIENT_ID 
				FROM P_LEW_MART_PIT.T_DIM_CLIENT 
				WHERE TRUE 
					AND PIT_COUNTRY_FG 	= 1 
					AND DELETED_FG 		= 0 
					AND REJECT_FG 		= 0 
					AND CURRENT_FG 		= 1 
				GROUP BY 1
			)		
		
        -- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)
        QUALIFY ROW_NUMBER() OVER(PARTITION BY itm.ITEM_SID ORDER BY itm.DWH_UPDATED DESC) = 1
    ) itm

	-- Item history information
    INNER JOIN
    (
        SELECT
              CLIENT_ID
			, ITEM_SID
			-- , ITEM_FAM_GRP_SID
			-- NToknov change 2.3 Use ITEM_FAM_GRP_SID as AS-IS (not as-was)
			, LAST_VALUE (ITEM_FAM_GRP_SID) OVER (PARTITION BY CLIENT_ID, ITEM_SID ORDER BY DWH_VALID_TO) AS ITEM_FAM_GRP_SID
			, BRAND_SID
			, DWH_VALID_FROM
			, DWH_VALID_TO
			, DWH_UPDATED
			, DELETED_FG
        FROM P_LEW_CORE.T_ITEM_HIST -- LIMIT 100
		WHERE TRUE
			AND CLIENT_ID IN (
				-- PIT Country
				SELECT 
					CLIENT_ID 
				FROM P_LEW_MART_PIT.T_DIM_CLIENT 
				WHERE TRUE 
					AND PIT_COUNTRY_FG 	= 1 
					
					AND DELETED_FG 		= 0 
					AND REJECT_FG 		= 0 
					AND CURRENT_FG 		= 1 
				GROUP BY 1
			)				
        -- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)
        QUALIFY ROW_NUMBER() OVER(PARTITION BY ITEM_SID, DWH_VALID_FROM ORDER BY DWH_UPDATED DESC) = 1
    ) itmh
        ON  TRUE
            AND itm.CLIENT_ID = itmh.CLIENT_ID
            AND itm.ITEM_SID  = itmh.ITEM_SID

	/*
    -- Retrieving Item Status --> ACTIVE vs INACTIVE
    -- on aggregation level country
    LEFT JOIN
	(
		SELECT 
			  CLIENT_ID
			, ITEM_SID
			, CASE_SIZE_DEC 																													AS CASE_SIZE
			, MIN(iff(ITEM_STATUS BETWEEN 6 AND 11,'ACTIVE', 'INACTTIVE')) 		OVER (PARTITION BY CLIENT_ID, ITEM_SID ORDER BY NULL)	 		AS ITEM_STATUS_CD
			, MIN(iff(ITEM_STATUS BETWEEN 6 AND 11,0::SMALLINT, 1::SMALLINT)) 	OVER (PARTITION BY CLIENT_ID, ITEM_SID ORDER BY NULL) 			AS ITEM_STATUS_FG		
			, MIN(DAT_REC_START) OVER (PARTITION BY CLIENT_ID, ITEM_SID ORDER BY NULL) 															AS DAT_REC_START
			, MAX(DAT_REC_END)   OVER (PARTITION BY CLIENT_ID, ITEM_SID ORDER BY NULL) 															AS DAT_REC_END		
		--SELECT *
		FROM P_LEW_CORE.T_WAWI_ITM_ITEM_WH 
		WHERE TRUE 	
			AND DIR_DELETE_FG 		= 0
			--AND ITEM_SID IN ( 33819, 1514139, 1591828 )
			--AND ITEM_SID IN (920025)
			AND MIN_ORDERUNIT 		IS NOT NULL
			AND CASE_SIZE_DEC 		IS NOT NULL
		QUALIFY ROW_NUMBER() OVER(PARTITION BY CLIENT_ID, ITEM_SID ORDER BY TIMESTAMP_STATUS_UPDATED DESC) = 1 
		
	) itms
	ON TRUE
		AND itms.CLIENT_ID 	= itm.CLIENT_ID
		AND itms.ITEM_SID	= itm.ITEM_SID
		AND itms.CASE_SIZE	= itm.CASE_SIZE 
		--AND itms.DAT_REC_START	BETWEEN itmh.DWH_VALID_TO AND itmh.DWH_VALID_FROM
		--AND itms.DAT_REC_END		BETWEEN itmh.DWH_VALID_TO AND itmh.DWH_VALID_FROM
	*/	
	
	-- Country Information
	INNER JOIN 	
	(	
		
		SELECT DISTINCT 
			  CLIENT_ID
			, COUNTRY_ORIG_DESCR
			, COUNTRY_INT_DESCR    
			, COUNTRY_NAT_DESCR
			, COUNTRY_DESCR
			, COUNTRY_ISO_CD
			, LANG_SID
			, CURR_SID
			, CURR_CD
			, EXCHANGE_RATE_TO_EUR
			, VALID_FROM_DT
			, CTR_EX_ELVIS_COUNTRY_FG
			, CTR_EX_ELVIS_COUNTRY_MIGRATION_DATE_FROM
			, CTR_EX_ELVIS_COUNTRY_MIGRATION_DATE_TO
			, CTR_ADV_WEEK_START_WEEKDAY_ID
		FROM P_LEW_MART_PIT.T_DIM_CLIENT 
		WHERE TRUE 
			AND PIT_COUNTRY_FG 			= 1 
			AND DELETED_FG 				= 0 
			AND REJECT_FG 				= 0 
			AND CURRENT_FG 				= 1 
	) cl 
    ON  TRUE
        AND itm.CLIENT_ID  = cl.CLIENT_ID
        AND itmh.CLIENT_ID = cl.CLIENT_ID	
	
   -- Get local item describtion
    LEFT JOIN
    (
		SELECT
			  CLIENT_ID
			, LANG_SID
			, ITEM_SID
			, ITEM_DESCR
		FROM P_LEW_CORE.T_ITEM_DESCR
		WHERE TRUE
			AND TRIM(LANG_CD) <> '@'    /*  country_sid = 7  */	
			-- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)
		QUALIFY ROW_NUMBER() OVER (PARTITION BY ITEM_SID, LANG_SID ORDER BY DWH_UPDATED DESC) = 1
		
	) itmd_l
	ON TRUE
		AND itm.CLIENT_ID 	= itmd_l.CLIENT_ID
		AND itm.ITEM_SID	= itmd_l.ITEM_SID	
		AND cl.LANG_SID		= itmd_l.LANG_SID
        AND cl.CLIENT_ID 	= itmd_l.CLIENT_ID				
	-- Get International item describtion
    LEFT JOIN
    (
        SELECT
              CLIENT_ID
			, LANG_SID
			, ITEM_SID
			, ITEM_DESCR
		FROM P_LEW_CORE.T_ITEM_DESCR
		WHERE TRUE
			AND TRIM(LANG_CD) = '@'    /*  country_sid = 7  */
        -- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)
        QUALIFY ROW_NUMBER() OVER (PARTITION BY ITEM_SID, LANG_SID ORDER BY DWH_UPDATED DESC) = 1
        				 	 
    ) itmd_i
    ON  TRUE
        AND itm.CLIENT_ID 	= itmd_i.CLIENT_ID
        AND itm.ITEM_SID 	= itmd_i.ITEM_SID
		AND cl.LANG_SID		= itmd_i.LANG_SID 
        AND cl.CLIENT_ID 	= itmd_i.CLIENT_ID		
		
WHERE TRUE
;
/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : VIEW fOR V_SOURCE_NAN
#-------------------------------------------------------------------------------
# Describtion: CREATE VIEW fOR V_SOURCE_NAN
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-08-16 Andreas Kurz     Initial Version
#  1.1	2022-07-11 Prasanna Ranjan	Added SUB_ITEM_GRP_SID & ITEM_GRP_INT_SID
#  1.2  2022-06-21 Andreas Kurz		Added DAT_VALID_FROM_MIGRATED_FG, changed DAT_VALID_FROM in cas of Ex-Elvis Country
#										Added section / case of Ex-Elvis and WAWI items
#  1.3	2023-07-07 Andreas Kurz		Added Brand_name and Brand_type CD (Marke / Eigenmarke)
#  1.4  2023-07-28 Nikolai Toknov	resolving the conflict between main branch and release branch
#  1.5	2024-09-23 Nikolai Toknov	Add schema name for f_CleanValidToDate
#-------------------------------------------------------------------------------
*/
/*
USE ROLE            R_LDL_D_PIT_ETL;
USE WAREHOUSE       WH_LDL_D_PIT_ETL_S;
USE DATABASE        LDL_PRODUCTION_CLONE_PIT_QS;
USE SCHEMA          P_LEW_MART_PIT;

---------------------------------------------------------------------
0.  CREATE VIEW in V_SOURCE_NAN
	Used for sourcing the Lookup Table DIM_NAN
	DROP VIEW P_LEW_MART_PIT.V_SOURCE_NAN 
------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW P_LEW_MART_PIT.V_SOURCE_NAN
COMMENT = 'Source View for Orig Item Nr (NAN)'
AS
SELECT
    
      fin.CLIENT_ID
	, fin.COUNTRY_DESCR
	, fin.COUNTRY_ISO_CD
    , fin.CTR_EX_ELVIS_COUNTRY_FG
	, fin.ORIG_ITEM_NR
    , fin.ORIG_ITEM_MSTR_NR
    , fin.CASE_SIZE                 
    , fin.DAT_VALID_FROM			 -- Geburtsdatum
    -- item information                                                                 
    , fin.ITEM_NAME
    , fin.ITEM_DESCR
    , fin.ITEM_INT_DESCR
	, fin.MAIN_ITEM_FG				-- ALWAYS 1
    -- additional item hierarchy join fields
	-- AS-WAS assignment
	, fin.ITEM_FAM_GRP_SID_SRC
	, fin.SUB_ITEM_GRP_SID_SRC
	, fin.ITEM_GRP_INT_SID_SRC
	-- AS-IS assignment
	, fin._ITEM_FAM_GRP_SID AS ITEM_FAM_GRP_SID
	, fin._SUB_ITEM_GRP_SID AS SUB_ITEM_GRP_SID
	, fin._ITEM_GRP_INT_SID AS ITEM_GRP_INT_SID                                            
    , fin.BRAND_SID
	-- AKU 2023-07-07
    , fin.BRAND_NAME
    , fin.BRAND_TYPE_CD	
	
	, fin.SCD_KEY_MD
    -- technical versioning                                                             
    , fin.VALID_FROM_DT
    , fin.VALID_TO_DT
	, fin.DELETED_FG
    , fin.DWH_UPDATED_TS
    , fin._SOURCE
    , MIN (fin._SOURCE) OVER (PARTITION BY fin.ORIG_ITEM_MSTR_NR ORDER BY NULL)									AS _MIN_SOURCE
--    , MAX (fin._SOURCE) OVER (PARTITION BY fin.ORIG_ITEM_MSTR_NR ORDER BY NULL)									AS _MAX_SOURCE
FROM
(
SELECT 
    
      itm.CLIENT_ID::INTEGER                                                            AS CLIENT_ID
	  
	, cl.COUNTRY_DESCR																	AS COUNTRY_DESCR
	, cl.COUNTRY_ISO_CD	  																AS COUNTRY_ISO_CD
    , cl.CTR_EX_ELVIS_COUNTRY_FG														AS CTR_EX_ELVIS_COUNTRY_FG
	
	--, itm.ITEM_SID::INTEGER                                                             AS ITEM_SID

    , itm.ORIG_ITEM_NR																	AS ORIG_ITEM_NR
    
    , itm.ORIG_ITEM_MSTR_NR																AS ORIG_ITEM_MSTR_NR
    
    , itm.CASE_SIZE        																AS CASE_SIZE                 
    , itm.DAT_VALID_FROM::DATE       													AS DAT_VALID_FROM			 -- Geburtsdatum
																						
    -- item information                                                                 
    , itm.ITEM_NAME
    , itm.ITEM_DESCR
    , itm.ITEM_INT_DESCR
																				
	, itm.MAIN_ITEM_FG            														AS MAIN_ITEM_FG				-- ALWAYS 1
																						                                          
    -- additional item hierarchy join fields
	-- AS-WAS assignment                                            
    , COALESCE(ihmh.ITEM_FAM_GRP_SID, -1000)::INTEGER                                  	AS ITEM_FAM_GRP_SID_SRC
	, COALESCE(ifg_hist.SUB_ITEM_GRP_SID, -1000)::INTEGER                               AS SUB_ITEM_GRP_SID_SRC
	, COALESCE(isg_hist.ITEM_GRP_INT_SID, -1000)::INTEGER                               AS ITEM_GRP_INT_SID_SRC
	, COALESCE(ihmh.BRAND_SID, -1000)::INTEGER                                         	AS BRAND_SID
 
	, br.BRAND_NAME																		AS BRAND_NAME
	, w_itm.BRAND_TYPE_CD                                                               AS BRAND_TYPE_CD
																																									

		-- AS-IS assignment
	, LAST_VALUE (ihmh.ITEM_FAM_GRP_SID) OVER (PARTITION BY 	itm.ORIG_ITEM_MSTR_NR, itm.ORIG_ITEM_NR, itm.DAT_VALID_FROM ORDER BY ihmh.DWH_VALID_TO) 		AS _ITEM_FAM_GRP_SID
	, LAST_VALUE (ifg_hist.SUB_ITEM_GRP_SID) OVER (PARTITION BY itm.ORIG_ITEM_MSTR_NR, itm.ORIG_ITEM_NR, itm.DAT_VALID_FROM ORDER BY ifg_hist.DWH_VALID_TO) 	AS _SUB_ITEM_GRP_SID
	, LAST_VALUE (isg_hist.ITEM_GRP_INT_SID) OVER (PARTITION BY itm.ORIG_ITEM_MSTR_NR, itm.ORIG_ITEM_NR, itm.DAT_VALID_FROM ORDER BY isg_hist.DWH_VALID_TO) 	AS _ITEM_GRP_INT_SID  
    
	, MD5(
                COALESCE(TO_CHAR(itm.ITEM_NAME        		),'')     ||
                COALESCE(TO_CHAR(itm.ITEM_DESCR       		),'')     ||
                COALESCE(TO_CHAR(itm.ITEM_INT_DESCR   		),'')     ||
                COALESCE(TO_CHAR(_ITEM_FAM_GRP_SID      	),'')     ||
				COALESCE(TO_CHAR(_SUB_ITEM_GRP_SID  		),'')     ||
				COALESCE(TO_CHAR(_ITEM_GRP_INT_SID  		),'')     ||
                COALESCE(TO_CHAR(ihmh.BRAND_SID   		    ),'')	  ||
				COALESCE(TO_CHAR(br.BRAND_NAME  		    ),'')	  ||
				COALESCE(TO_CHAR(w_itm.BRAND_TYPE_CD  	    ),'')						
                
        ) 																				AS SCD_KEY_MD
																						
    -- technical versioning                                                             
    , COALESCE(ihmh.DWH_VALID_FROM, '1900-01-01'::DATE)::DATE                       	AS VALID_FROM_DT
    , P_LEW_MART_PIT.f_CleanValidToDate(ihmh.DWH_VALID_TO)::DATE                                   	AS VALID_TO_DT
																						
	, ihmh.DELETED_FG::SMALLINT                                                     	AS DELETED_FG
    , ihmh.DWH_UPDATED::TIMESTAMP                                                   	AS DWH_UPDATED_TS

    , itm._SOURCE																			AS _SOURCE
FROM
	-- orig_item_nr / NAN only information
	-- item Union all
	(
		-- Orig Item_nr from ex Elvis countries
		
		-- ----------------------------------------
		-- PIT Country Ex Elvis Countries SAP Items
		-- ----------------------------------------		
		SELECT
			  itm.CLIENT_ID	  
			, itm.ITEM_SID
			, itm.SRC_ORIG_ITEM_NR
			, itm.CONFIG_ITEM_CD
			, itm.SRC_MATNR
			--, REGEXP_REPLACE(itm.SRC_MATNR, '(_|[A-z])','') 											AS _SRC_MATNR
			, itm.SRC_MATNR																				AS _SRC_MATNR
			, itm.LOG_VAR_CD		
			, itm.CONFIG_ITEM_CD		
			, 1::SMALLINT																				AS MAIN_ITEM_FG
			, COALESCE(TRY_TO_NUMBER(itm.SRC_ORIG_ITEM_NR), TRY_TO_NUMBER(itm.CONFIG_ITEM_CD), TRY_TO_NUMBER(_SRC_MATNR), -1000)::NUMBER(38,0)	-- Default Value -1000 per client             
																										AS ORIG_ITEM_NR
			, try_to_number(itm.SRC_CASE_SIZE)::NUMBER(38,5)               								AS CASE_SIZE		
			, COALESCE(itm.SRC_DAT_VALID_FROM, cl.CTR_EX_ELVIS_COUNTRY_MIGRATION_DATE_TO + 1 ) 			AS DAT_VALID_FROM			 -- Geburtsdatum, if empty --> Migration Date
			
			-- Added new Indicator		
			, iff(itm.SRC_DAT_VALID_FROM::DATE IS NULL
					, 1::SMALLINT
					, 0::SMALLINT) 																		AS DAT_VALID_FROM_MIGRATED_FG				
			
			
			-- item information                                                                 
			, COALESCE(ITEM_NAME     	 , itmd_i.ITEM_DESCR    , itmd_l.item_descr , 'n/A')::VARCHAR   AS ITEM_NAME
			, COALESCE(itmd_l.item_descr , ITEM_NAME        	, itmd_i.item_descr , 'n/A')::VARCHAR   AS ITEM_DESCR
			, COALESCE(itmd_i.item_descr , itmd_l.item_descr 	, ITEM_NAME     	, 'n/A')::VARCHAR   AS ITEM_INT_DESCR
			
			, iff(ORIG_ITEM_NR<0
					,(ORIG_ITEM_NR * 100::INTEGER ) - itm.CLIENT_ID
					,(ORIG_ITEM_NR * 100::INTEGER ) + itm.CLIENT_ID
				)																						AS ORIG_ITEM_MSTR_NR
			, itm.DWH_UPDATED
		
			, 1::SMALLINT																				AS _SOURCE
		FROM P_LEW_CORE.T_ITEM itm
	
		-- ----------------------------------------
		-- PIT Country Ex Elvis Countries SAP Items
		-- ----------------------------------------
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
				AND CTR_EX_ELVIS_COUNTRY_FG = 1
				
				AND DELETED_FG 				= 0 
				AND REJECT_FG 				= 0 
				AND CURRENT_FG 				= 1 
		) cl 
		ON TRUE
			AND itm.CLIENT_ID 	= cl.CLIENT_ID
		
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
			AND ORIG_ITEM_NR > 0
			AND itm.CLIENT_ID = cl.CLIENT_ID
			AND 
				(
				itm.LOG_VAR_CD = '1' 
					OR
				itm.LOG_VAR_CD IS NULL
				)
			AND itm.SRC_MATNR 		IS NOT NULL -- SAP Item
			AND itm.SRC_MATNR 		NOT LIKE '@%'
			AND itm.CONFIG_ITEM_CD 	IS NULL
		
		-- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)
		QUALIFY ROW_NUMBER() OVER(PARTITION BY itm.CLIENT_ID, ORIG_ITEM_NR, DAT_VALID_FROM ORDER BY itm.DWH_UPDATED DESC) = 1		
		
		UNION ALL
		
		-- ----------------------------------------
		-- PIT Country Ex Elvis Countries WAWI Items
		-- ----------------------------------------		
		SELECT
			  itm.CLIENT_ID	  
			, itm.ITEM_SID
			, itm.SRC_ORIG_ITEM_NR
			, itm.CONFIG_ITEM_CD
			, itm.SRC_MATNR
			--, REGEXP_REPLACE(itm.SRC_MATNR, '(_|[A-z])','') 											AS _SRC_MATNR
			, itm.SRC_MATNR																				AS _SRC_MATNR
			, itm.LOG_VAR_CD		
			, itm.CONFIG_ITEM_CD
			, 1::SMALLINT 																				AS MAIN_ITEM_FG			
			, itm.ORIG_ITEM_NR																			AS ORIG_ITEM_NR
			, itm.CASE_SIZE               																AS CASE_SIZE		
			, itm.DAT_VALID_FROM 																		AS DAT_VALID_FROM			 -- Geburtsdatum, if empty --> Migration Date
			
			-- Added new Indicator		
			, itm.DAT_VALID_FROM_MIGRATED_FG															AS DAT_VALID_FROM_MIGRATED_FG				
			
			
			-- item information                                                                 
			, COALESCE(itm.ITEM_NAME     , itmd_i.ITEM_DESCR    , itmd_l.item_descr , 'n/A')::VARCHAR   AS ITEM_NAME
			, COALESCE(itmd_l.item_descr , itm.ITEM_NAME        , itmd_i.item_descr , 'n/A')::VARCHAR   AS ITEM_DESCR
			, COALESCE(itmd_i.item_descr , itmd_l.item_descr 	, itm.ITEM_NAME     , 'n/A')::VARCHAR   AS ITEM_INT_DESCR
			
			, iff(ORIG_ITEM_NR<0
					,(ORIG_ITEM_NR * 100::INTEGER ) - itm.CLIENT_ID
					,(ORIG_ITEM_NR * 100::INTEGER ) + itm.CLIENT_ID
				)																						AS ORIG_ITEM_MSTR_NR
			, itm.DWH_UPDATED
		
			, 2::SMALLINT																				AS _SOURCE
		FROM 
		
		-- retrieve ITEM_NAME for latest item_sid of orig_item_nr 
		(
			SELECT
				  CLIENT_ID	  
				, ITEM_SID
				, SRC_ORIG_ITEM_NR
				, CONFIG_ITEM_CD
				, SRC_MATNR
				, REGEXP_REPLACE(SRC_MATNR, '(_|[A-z])','') AS _SRC_MATNR
				, LOG_VAR_CD
				, iff(LOWER(TRIM(item_name)) LIKE 'mainitem%',1::SMALLINT, 0::SMALLINT)             AS MAIN_ITEM_FG
				
				, COALESCE(TRY_TO_NUMBER(itm.SRC_ORIG_ITEM_NR), TRY_TO_NUMBER(itm.CONFIG_ITEM_CD), TRY_TO_NUMBER(_SRC_MATNR), -1000)::NUMBER(38,0)	-- Default Value -1000 per client             
																									AS ORIG_ITEM_NR
				, try_to_number(itm.SRC_CASE_SIZE)::NUMBER(38,5)               						AS CASE_SIZE		
				, COALESCE(SRC_DAT_VALID_FROM, '8888-12-31'::DATE)     								AS DAT_VALID_FROM			 -- Geburtsdatum, if empty --> Migration Date
				-- Added new Indicator
				, iff(SRC_DAT_VALID_FROM::DATE IS NULL
					, 1::SMALLINT
					, 0::SMALLINT) 																	AS DAT_VALID_FROM_MIGRATED_FG				
				, ITEM_NAME			
				, DWH_UPDATED
			FROM P_LEW_CORE.T_ITEM itm
			WHERE TRUE
				AND ORIG_ITEM_NR > 0
				AND CLIENT_ID IN (
					SELECT  
						CLIENT_ID
					FROM P_LEW_MART_PIT.T_DIM_CLIENT 
					WHERE TRUE 
						AND PIT_COUNTRY_FG 			= 1 
						AND CTR_EX_ELVIS_COUNTRY_FG = 1
				
						AND DELETED_FG 				= 0 
						AND REJECT_FG 				= 0 
						AND CURRENT_FG 				= 1	
					GROUP BY 1
				)
				AND CASE_SIZE 		IS NOT NULL
				AND MAIN_ITEM_FG	= 0
						
			-- Take first ITEM_SID and the lastest record 
			QUALIFY ROW_NUMBER() OVER(PARTITION BY CLIENT_ID, ORIG_ITEM_NR, DAT_VALID_FROM ORDER BY itm.ITEM_SID ASC, itm.DWH_UPDATED DESC) = 1	
		) itm
	
		-- ----------------------------------------
		-- PIT Country Ex Elvis Countries SAP Items
		-- ----------------------------------------
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
				AND CTR_EX_ELVIS_COUNTRY_FG = 1
				
				AND DELETED_FG 				= 0 
				AND REJECT_FG 				= 0 
				AND CURRENT_FG 				= 1 
		) cl 
		ON TRUE
			AND itm.CLIENT_ID 	= cl.CLIENT_ID
		
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
			--AND itm.ORIG_ITEM_NR 	IN (204749,359716,367808)
			--AND itm.CLIENT_ID		= 1
	
			
		
		-- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)
		QUALIFY ROW_NUMBER() OVER(PARTITION BY itm.CLIENT_ID, ORIG_ITEM_NR, DAT_VALID_FROM ORDER BY itm.DWH_UPDATED DESC) = 1		

	
		UNION ALL
	
		-- ----------------------------------------
		-- Orig Item_nr from PIT Country WAWI countries WAWI Items
		-- ----------------------------------------
		
	
		SELECT
				itm.CLIENT_ID	  
				, itm.ITEM_SID
				, itm.SRC_ORIG_ITEM_NR
				, itm.CONFIG_ITEM_CD
				, itm.SRC_MATNR
				, itm._SRC_MATNR
				, itm.LOG_VAR_CD
				, itm.CONFIG_ITEM_CD
				, 1::SMALLINT																				AS MAIN_ITEM_FG
				, itm.ORIG_ITEM_NR																			AS ORIG_ITEM_NR
				, NULL               																		AS CASE_SIZE		
				, itm.DAT_VALID_FROM																		AS DAT_VALID_FROM			 -- Geburtsdatum, if empty --> Migration Date
				, itm.DAT_VALID_FROM_MIGRATED_FG
	
				, COALESCE(itm.ITEM_NAME     , itmd_i.ITEM_DESCR    , itmd_l.item_descr , 'n/A')::VARCHAR   AS ITEM_NAME
				, COALESCE(itmd_l.item_descr , itm.item_name        , itmd_i.item_descr , 'n/A')::VARCHAR   AS ITEM_DESCR
				, COALESCE(itmd_i.item_descr , itmd_l.item_descr 	, itm.item_name     , 'n/A')::VARCHAR   AS ITEM_INT_DESCR
				
				, iff(ORIG_ITEM_NR<0
						,(ORIG_ITEM_NR * 100::INTEGER ) - itm.CLIENT_ID
						,(ORIG_ITEM_NR * 100::INTEGER ) + itm.CLIENT_ID
					)																						AS ORIG_ITEM_MSTR_NR			
	
				, itm.DWH_UPDATED
				, 0::SMALLINT																				AS _SOURCE
				
		FROM 
		
			-- retrieve ITEM_NAME for latest item_sid of orig_item_nr 
			(
				SELECT
					  CLIENT_ID	  
					, ITEM_SID
					, SRC_ORIG_ITEM_NR
					, CONFIG_ITEM_CD
					, SRC_MATNR
					, REGEXP_REPLACE(SRC_MATNR, '(_|[A-z])','') AS _SRC_MATNR
					, LOG_VAR_CD
					, iff(LOWER(TRIM(item_name)) LIKE 'mainitem%',1::SMALLINT, 0::SMALLINT)             AS MAIN_ITEM_FG
					, COALESCE(TRY_TO_NUMBER(itm.SRC_ORIG_ITEM_NR), TRY_TO_NUMBER(itm.CONFIG_ITEM_CD), TRY_TO_NUMBER(_SRC_MATNR), -1000)::NUMBER(38,0)	-- Default Value -1000 per client             
																										AS ORIG_ITEM_NR
					, try_to_number(itm.SRC_CASE_SIZE)::NUMBER(38,5)               						AS CASE_SIZE		
					, COALESCE(SRC_DAT_VALID_FROM, '8888-12-31'::DATE)     								AS DAT_VALID_FROM			 -- Geburtsdatum, if empty --> Migration Date
					-- Added new Indicator
					, iff(SRC_DAT_VALID_FROM::DATE IS NULL
						, 1::SMALLINT
						, 0::SMALLINT) 																	AS DAT_VALID_FROM_MIGRATED_FG				
					, ITEM_NAME			
					, DWH_UPDATED
				FROM P_LEW_CORE.T_ITEM itm
				WHERE TRUE
					AND ORIG_ITEM_NR > 0
					AND CLIENT_ID IN (
						SELECT  
							CLIENT_ID
						FROM P_LEW_MART_PIT.T_DIM_CLIENT 
						WHERE TRUE 
							AND PIT_COUNTRY_FG 			= 1 
							AND CTR_EX_ELVIS_COUNTRY_FG = 0
					
							AND DELETED_FG 				= 0 
							AND REJECT_FG 				= 0 
							AND CURRENT_FG 				= 1	
						GROUP BY 1
					)
					AND CASE_SIZE 		IS NOT NULL
					AND MAIN_ITEM_FG	= 0
							
				-- Take first ITEM_SID and the lastest record 
				QUALIFY ROW_NUMBER() OVER(PARTITION BY CLIENT_ID, ORIG_ITEM_NR, DAT_VALID_FROM ORDER BY itm.ITEM_SID ASC, itm.DWH_UPDATED DESC) = 1	
			) itm
			
			-- PIT Country Wawi Countries
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
					AND CTR_EX_ELVIS_COUNTRY_FG = 0
					AND DELETED_FG 				= 0 
					AND REJECT_FG 				= 0 
					AND CURRENT_FG 				= 1 
			) cl 
			ON TRUE
				AND itm.CLIENT_ID 	= cl.CLIENT_ID
			
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
			
			-- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)
			QUALIFY ROW_NUMBER() OVER(PARTITION BY itm.CLIENT_ID, itm.ORIG_ITEM_NR, itm.DAT_VALID_FROM ORDER BY itm.DWH_UPDATED DESC) = 1		
	) itm

	-- Item history information
    INNER JOIN
    (
        SELECT
              CLIENT_ID
			, ITEM_SID
			, ITEM_FAM_GRP_SID
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
					AND PIT_COUNTRY_FG 			= 1 
					AND DELETED_FG 				= 0 
					AND REJECT_FG 				= 0 
					AND CURRENT_FG 				= 1 
				GROUP BY 1
			)
			AND ITEM_FAM_GRP_SID > 0
        -- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)
        QUALIFY ROW_NUMBER() OVER(PARTITION BY ITEM_SID, DWH_VALID_FROM ORDER BY DWH_UPDATED DESC) = 1
    ) ihmh
    ON  TRUE
		AND itm.CLIENT_ID = ihmh.CLIENT_ID
        AND itm.ITEM_SID  = ihmh.ITEM_SID
 
	-- WAWI Item -- to retrieve Buyinglist_type
    LEFT JOIN
	(
        SELECT
			  CLIENT_ID::INTEGER                                                     AS CLIENT_ID
			, ITEM_SID::INTEGER                                                      AS ITEM_SID
																							
			, COALESCE(DAT_VALID_FROM::DATE, '8888-12-31'::DATE)::DATE               AS DAT_VALID_FROM
																							
			, BUYING_LIST_TYPE_ID::INTEGER                                           AS _BUYING_LIST_TYPE_ID
			, P_LEW_MART_PIT.f_GetBrandTypeCd(_BUYING_LIST_TYPE_ID)                  AS BRAND_TYPE_CD			
			, COALESCE(BUYING_LIST_TYPE_DESC, 'N/A')::VARCHAR                        AS BUYING_LIST_TYPE_DESCR

			
			-- technical versioning
			, COALESCE(DAT_REC_START, '1900-01-01'::DATE)::DATE                      AS VALID_FROM_DT
			, P_LEW_MART_PIT.f_CleanValidToDate(DAT_REC_END)::DATE                   AS VALID_TO_DT
        FROM P_LEW_CORE.T_WAWI_ITM_ITEM
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
        QUALIFY ROW_NUMBER() OVER (PARTITION BY CLIENT_ID, ITEM_SID, DAT_REC_START ORDER BY DAT_VALID_FROM DESC) = 1
    ) w_itm
	ON TRUE
		AND w_itm.CLIENT_ID = ihmh.CLIENT_ID
        AND w_itm.ITEM_SID  = ihmh.ITEM_SID
		
	-- Brand Info
	LEFT JOIN
	(
		SELECT
			  CLIENT_ID
			, BRAND_SID
			, SRC_BRAND_CD
			, BRAND_NAME
			, BRAND_TYPE_CD
		FROM P_LEW_CORE.T_BRAND
		WHERE TRUE
			AND CLIENT_ID IN (
							-- PIT Country
							SELECT 
								CLIENT_ID 
							FROM P_LEW_MART_PIT.T_DIM_CLIENT 
							WHERE TRUE 
								AND PIT_COUNTRY_FG 			= 1 
								AND DELETED_FG 				= 0 
								AND REJECT_FG 				= 0 
								AND CURRENT_FG 				= 1 
							GROUP BY 1
						) 
	) br
	ON  TRUE
		AND ihmh.CLIENT_ID  = br.CLIENT_ID
        AND ihmh.BRAND_SID  = br.BRAND_SID		
	-- Sub item grp information
	LEFT JOIN 
	(
		SELECT DISTINCT
			  CLIENT_ID
			, SUB_ITEM_GRP_SID
			, ITEM_FAM_GRP_SID
			, DWH_VALID_FROM
			, DWH_VALID_TO
		FROM P_LEW_CORE.T_ITEM_FAMILYGROUP_HIST
		WHERE TRUE
			AND SUB_ITEM_GRP_SID > 0
			AND ITEM_FAM_GRP_SID > 0
		-- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)
		QUALIFY ROW_NUMBER() OVER (PARTITION BY CLIENT_ID, ITEM_FAM_GRP_SID, DWH_VALID_FROM ORDER BY DWH_UPDATED DESC) = 1
	) ifg_hist
	ON TRUE
		AND ihmh.CLIENT_ID    		= ifg_hist.CLIENT_ID
		AND ihmh.ITEM_FAM_GRP_SID 	= ifg_hist.ITEM_FAM_GRP_SID
		AND ihmh.DWH_VALID_FROM 	BETWEEN ifg_hist.DWH_VALID_FROM AND ifg_hist.DWH_VALID_TO
	
	-- Item grp int information
	LEFT JOIN
	(
		SELECT DISTINCT
			  CLIENT_ID
			, SUB_ITEM_GRP_SID
			, ITEM_GRP_INT_SID
			, DWH_VALID_FROM
			, DWH_VALID_TO
		FROM P_LEW_CORE.T_SUBITEMGROUP_HIST
		WHERE TRUE
			AND SUB_ITEM_GRP_SID > 0
			AND ITEM_GRP_INT_SID > 0
		-- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)
		QUALIFY ROW_NUMBER() OVER(PARTITION BY CLIENT_ID, SUB_ITEM_GRP_SID, DWH_VALID_FROM ORDER BY DWH_UPDATED DESC) = 1
	) isg_hist    
	ON TRUE
		AND ifg_hist.CLIENT_ID        	= isg_hist.CLIENT_ID
		AND ifg_hist.SUB_ITEM_GRP_SID 	= isg_hist.SUB_ITEM_GRP_SID
		AND ifg_hist.DWH_VALID_FROM 	BETWEEN isg_hist.DWH_VALID_FROM AND isg_hist.DWH_VALID_TO
        
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

WHERE TRUE
	AND itm.MAIN_ITEM_FG 	= 1
-- 	AND itm.ORIG_ITEM_NR 	= 204088 
--	AND itm.CLIENT_ID 		= 1
) fin
WHERE TRUE
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27
-- Give Exelvis countries SAP item periority over identical Wawi items
-- QUALIFY _SOURCE = _MIN_SOURCE
QUALIFY ROW_NUMBER() OVER(PARTITION BY CLIENT_ID, ORIG_ITEM_NR, DAT_VALID_FROM, VALID_FROM_DT, DELETED_FG ORDER BY NULL) = 1
;
--SELECT * FROM P_LEW_MART_PIT.V_SOURCE_NAN WHERE TRUE AND CLIENT_ID = 1 AND ORIG_ITEM_NR 	IN (204749,359716,367808)
--SELECT * FROM P_LEW_MART_PIT.V_SOURCE_NAN WHERE TRUE AND CLIENT_ID = 1 AND ORIG_ITEM_NR 	= 204749
--SELECT * FROM P_LEW_MART_PIT.V_SOURCE_NAN WHERE TRUE AND CLIENT_ID = 10 AND ORIG_ITEM_NR =5716037
--SELECT * FROM P_LEW_MART_PIT.V_SOURCE_NAN WHERE TRUE AND CLIENT_ID = 1 AND ORIG_ITEM_NR = 204406 AND DAT_VALID_FROM = '2019-10-25'::DATE LIMIT 100
--SELECT * FROM P_LEW_MART_PIT.V_SOURCE_NAN WHERE ORIG_ITEM_NR IN (214309) AND CLIENT_ID = 1
--SELECT * FROM P_LEW_MART_PIT.V_SOURCE_NAN WHERE ORIG_ITEM_NR IN (1254) AND DAT_VALID_FROM = '2008-11-20'::DATE AND CLIENT_ID = 1 LIMIT 100
--SELECT * FROM P_LEW_MART_PIT.V_SOURCE_NAN WHERE TRUE AND CLIENT_ID = 1 AND ORIG_ITEM_NR = -1000 AND DAT_VALID_FROM = '2019-10-25'::DATE
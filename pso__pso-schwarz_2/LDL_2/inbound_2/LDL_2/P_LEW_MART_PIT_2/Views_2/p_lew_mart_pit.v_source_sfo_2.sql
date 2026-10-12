/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for v_source_sfo_2
#-------------------------------------------------------------------------------
# Describtion: Create View for v_source_sfo_2
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-08-16 Massimo Morelli	   	Initial version
#  1.1  2021-09-16 Aparna Rayanki	   	relavant source columns and filters are added
#  1.2  2021-09-29 Dirk Hering         	Use example role added, data types added, column order, formatting
#  1.3  2021-10-08 Dirk Hering         	New target names: sub_item_grp_src_cd
#  1.4	2022-01-19 Andreas Kurz			Reviewed and some corrections
#  2.0	2022-07-16 Nikolai Toknov  		Changing the script for DevOps
#  2.1  2022-07-18 Andreas Kurz			Reworked structure
#  2.2	2024-01-05 Andreas Kurz			Added some comments
#  2.3	2024-03-13 Andreas Kurz			Added structure based on WAWI Expert Input 
#											removed join to VAT Code
#  2.4  2024-03-14 Andreas Kurz			Removed column PV_UWG_GROUP_FG because always 0 
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R60001;
USE SCHEMA 		P_LEW_MART_PIT_2;
*/

CREATE OR REPLACE VIEW P_LEW_MART_PIT.V_SOURCE_SFO_2
COMMENT = 'Source View for SFO (PV) and Storeform - Kleinbelege'
AS
SELECT

      sfof.CLIENT_ID::INTEGER                       					AS CLIENT_ID
    , sfof.ITEM_SID::INTEGER                        					AS ITEM_SID
    , sfof.LOC_SID_STORE::INTEGER                   					AS STORE_SID
    , sfof.DWH_CAL_DT::DATE                        						AS DAY_DT
																
    , sfof.SUBITEMGRP_CD::VARCHAR              	   						AS SUB_ITEM_GRP_SRC_CD 
							
	, sfof.VAT_ID::NUMBER(38,0)                    						AS VAT_ID
					
	, sfof.WH_GROSS_PRICE::NUMBER(38,5)            						AS SFO_SALES_PRICE_OLD_GROSS
	, sfof.WH_NET_PRICE::NUMBER(38,5)            						AS SFO_SALES_PRICE_OLD_NET	

    , sfof.NEW_GROSS_PRICE::NUMBER(38,5)           						AS SFO_SALES_PRICE_NEW_GROSS
    , sfof.NEW_NET_PRICE::NUMBER(38,5)           						AS SFO_SALES_PRICE_NEW_NET
	
	, sfof.ORG_GROSS_PRICE::NUMBER(38,5) 								AS SFO_ORG_GROSS_PRICE
	, sfof.ORG_NET_PRICE::NUMBER(38,5)                                  AS SFO_ORG_NET_PRICE
																	 
	, sfof.STORE_GROSS_PRICE::NUMBER(38,5) 			                    AS SFO_STORE_GROSS_PRICE
	, sfof.STORE_NET_PRICE::NUMBER(38,5)                                AS SFO_STORE_NET_PRICE
			
	, sfof.STORE_GROSS_PRICE * (-1.0)									AS SFO_ITEM_DISCOUNT_GROSS_VAL
	, sfof.STORE_NET_PRICE * (-1.0)										AS SFO_ITEM_DISCOUNT_NET_VAL
			
	, sfof.TOTAL_QTY::NUMBER(38,5)										AS TOTAL_QTY 			
	
	, sfof.WAREHOUSE_SID::NUMBER(38,0)									AS WAREHOUSE_SID
	, sfof.ACT_PRICE_GRP_ID::NUMBER(38,0)								AS ACT_PRICE_GRP_ID
					
    -- Version technical fields					
    , '1900-01-01'::DATE                           						AS VALID_FROM_DT
    , '9999-12-31'::DATE                           						AS VALID_TO_DT
    , 0::SMALLINT			                       						AS DELETED_FG
									
	, sfof.DWH_CREATED::TIMESTAMP										AS DWH_CREATED_TS
	, sfof.DWH_UPDATED::TIMESTAMP										AS DWH_UPDATED_TS
				
	, sfof.MODUSER::VARCHAR												AS MODUSER
	
	-- AKU 2024-03-13 Conditions to identify WAWI PV Grund
	-- Abverkaufsbasierte PV aus LP/PD_2 (NPPS)
	-- Bestands PV
	-- Preisgebietsdifferenz (3)
	
	-- Open Question if ASP or ASP440 
	, iff(sfof.MODUSER LIKE 'ASP%', 1, 0)::SMALLINT						AS ASP_USER_FG 	
	-- Open Question if DAY or DAY850
	, iff(sfof.MODUSER LIKE 'DAY%', 1, 0)::SMALLINT						AS DAY_USER_FG 			
	
	, iff(COALESCE(sfof.NEW_GROSS_PRICE,-1) 	> 0, 1, 0)::SMALLINT	AS NEW_GROSS_PRICE_FG					
	, iff(COALESCE(sfof.WH_GROSS_PRICE,-1) 		> 0, 1, 0)::SMALLINT	AS WH_GROSS_PRICE_FG					
	, iff(COALESCE(sfof.STORE_GROSS_PRICE,-1) 	> 0, 1, 0)::SMALLINT	AS STORE_GROSS_PRICE_FG
	, iff(COALESCE(sfof.TOTAL_QTY,-1) 			> 0, 1, 0)::SMALLINT 	AS TOTAL_QTY_FG
	
	-- Condition to detect WAWI PV-Grund - Note: needs to be verified by WAWI Expert
	, CASE
		WHEN DAY_USER_FG = 1 
			THEN 3::SMALLINT		 -- 'Preisgebietsdifferenz'
		WHEN ASP_USER_FG = 1 AND NEW_GROSS_PRICE_FG = 1 AND WH_GROSS_PRICE_FG = 1
			THEN 2::SMALLINT		 -- 'Bestands PV'
		WHEN ASP_USER_FG = 1 AND NEW_GROSS_PRICE_FG = 0 AND WH_GROSS_PRICE_FG = 1
			THEN 1::SMALLINT		 -- 'Abverkaufsbasierte PV aus LP/PD_2 (NPPS)'
		ELSE
			-1::SMALLINT		
	  END 																AS WAWI_PV_TYPE_ID
	, CASE
		WHEN DAY_USER_FG = 1 
			THEN 'Preisgebietsdifferenz'::VARCHAR
		WHEN ASP_USER_FG = 1 AND NEW_GROSS_PRICE_FG = 1 AND WH_GROSS_PRICE_FG = 1
			THEN 'Bestands PV'::VARCHAR
		WHEN ASP_USER_FG = 1 AND NEW_GROSS_PRICE_FG = 0 AND WH_GROSS_PRICE_FG = 1
			THEN 'Abverkaufsbasierte PV aus LP/PD_2 (NPPS)'::VARCHAR
		ELSE
			'n/A'::VARCHAR		
	  END																AS WAWI_PV_TYPE_DESCR	
FROM    
	
	(
		SELECT 
			  sfof.CLIENT_ID
			, sfof.LOC_SID_STORE    
			, sfof.ITEM_SID    		

			, sfof.WAREHOUSE_SID
			, sfof.DWH_CAL_DT
			, sfof.ACT_PRICE_GRP_ID	
			, sfof.NEW_PRICE_GRP_ID

			, sfof.VAT_ID
				
			, sfof.WH_GROSS_PRICE
			, sfof.WH_NET_PRICE 
			
			, sfof.NEW_GROSS_PRICE	
			, sfof.NEW_NET_PRICE				

			, sfof.ORG_GROSS_PRICE	
			, sfof.ORG_NET_PRICE   
			
			, sfof.STORE_GROSS_PRICE			
			, sfof.STORE_NET_PRICE  	
			
			, sfof.TOTAL_QTY										

			, sfof.SUBITEMGRP_CD

			, sfof.DWH_CREATED
			, sfof.DWH_UPDATED
			
			, sfof.MODUSER
			

		FROM 
			(
				SELECT
					  CLIENT_ID
					, LOC_SID_STORE    
					, ITEM_SID    		
					, LOC_SID_WH 				AS WAREHOUSE_SID
					--, DAYEND_DT
					, DWH_CAL_DT
					, MAX( SUBITEMGRP_CD	) AS 					SUBITEMGRP_CD	

					, MAX(DWH_CREATED) AS DWH_CREATED
					, MAX(DWH_UPDATED) AS DWH_UPDATED

					, MAX(MODUSER)		AS MODUSER
					
					, MIN(ACT_PRICE_GRP_ID) 		AS ACT_PRICE_GRP_ID
					, MIN(NEW_PRICE_GRP_ID)			AS NEW_PRICE_GRP_ID
					, MIN(VAT_ID)					AS VAT_ID

					, MEDIAN(WH_GROSS_PRICE		) 	AS WH_GROSS_PRICE
					, MEDIAN(WH_NET_PRICE       ) 	AS WH_NET_PRICE
	
					, MEDIAN(NEW_GROSS_PRICE) 		AS NEW_GROSS_PRICE	
					, MEDIAN(NEW_NET_PRICE      ) 	AS NEW_NET_PRICE

					, MEDIAN(ORG_GROSS_PRICE	) 	AS ORG_GROSS_PRICE	
					, MEDIAN(ORG_NET_PRICE      ) 	AS ORG_NET_PRICE    
					                                   
					, MEDIAN(STORE_GROSS_PRICE  ) 	AS STORE_GROSS_PRICE
					, MEDIAN(STORE_NET_PRICE    ) 	AS STORE_NET_PRICE  

					, SUM(TOTAL_QTY)				AS TOTAL_QTY

				-- DESC TABLE P_LEW_CORE.T_STORE_FORM_2  
				--SELECT *
					FROM P_LEW_CORE.T_STORE_FORM_2 
				WHERE TRUE
					/*TESTING*/
					--AND CLIENT_ID = 4
					--AND DWH_CAL_DT = '2024-01-19'::DATE
					--AND ITEM_SID = 5663088
					--AND LOC_SID_STORE = 17277
					/*TESTING*/
					
					-- AKU 2024-01-16 reduce nbr of touched rows
					AND DWH_CAL_DT 		>= '2019-01-01'::DATE 
					AND DWH_CAL_DT		<= CURRENT_DATE()					
					/*
					--> PV
					190 Korr. Gesellschafts-PV
					134 Filial-PV
					144 Korr. Filial-PV
					180 Gesellschafts-PV
					*/  
					AND SFO_TYPE_ID IN (130, 131, 132, 133, 135, 138, 139, 140, 141, 142, 143, 145, 148, 149, 151, 161, 144, 134, 180, 190)
					AND (
						
						SFO_TYPE_ID    IN (134,144,180,190) AND PCWO_REASON_ID IN (41)				
					/*
					41	Werbe-PV Only
					42	Dauerhafte Preisaenderung
					43	Restantenverwertung (PV) Sortiment
					*/
						)
						
					-- 131	Rücksendung Filiale
					-- 141	Korr. Rücksendung Filiale

					AND NOT(
						SFO_TYPE_ID IN (131, 141) 
						
						AND TRY_TO_NUMBER(SUBITEMGRP_CD) IS NOT NULL 
						AND 
							(
								(
								TRY_TO_NUMBER(SUBITEMGRP_CD) BETWEEN 100 AND 399
								)
								OR 
								(
								TRY_TO_NUMBER(SUBITEMGRP_CD) IN (75, 76)
								)
							)
						)
						
				
				GROUP BY 1,2,3,4,5
			)
			sfof
	
				
		-- clustered by client_id and dwh_cal_dt
		WHERE TRUE 	
 			-- PIT Country_2
			AND sfof.CLIENT_ID IN (
				-- PIT Country_2
				SELECT 
					CLIENT_ID 
				FROM P_LEW_MART_PIT.T_DIM_CLIENT_2 
				WHERE TRUE 
					AND PIT_COUNTRY_FG 	= 1 
					
					AND DELETED_FG 		= 0 
					AND REJECT_FG 		= 0 
					AND CURRENT_FG 		= 1 
				GROUP BY 1
			)
			
				
	) sfof
	

WHERE TRUE 
;

--SELECT * FROM P_LEW_MART_PIT.V_SOURCE_SFO_2 WHERE TRUE AND CLIENT_ID = 23 AND STORE_SID = 11080 AND DAY_DT = '2023-12-16'::DATE AND ITEM_SID in (3893584) LIMIT 10
--SELECT * FROM P_LEW_MART_PIT.V_SOURCE_SFO_2 WHERE TRUE AND CLIENT_ID = 23 AND DAY_DT = '2023-11-20'::DATE AND STORE_SID = 17065 AND ITEM_SID IN (1007780, 5294139) LIMIT 10 
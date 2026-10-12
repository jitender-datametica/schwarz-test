/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for V_SOURCE_ADP_ADVERTISEMENT_THEME
#-------------------------------------------------------------------------------
# Describtion: Create View for V_SOURCE_ADP_ADVERTISEMENT_THEME
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
# 1.0 2021-09-01 Aparna Rayanki 	Initial version
# 1.1 2021-09-29 Dirk Hering    	Use example role added, data types added, column order, formatting
# 1.2 2021-10-11 Aparna Rayanki 	Added join with t_campaign and theme_descr column
# 1.3 2021-10-11 Dirk Hering    	Deduplication from source (Qualify Row Number = 1)
# 1.4 2022-02-02 Andreas Kurz		Added Anzahl Werbetage, added clean validfromDt Function
# 1.5 2022-03-14 Massimo Morelli	corrected typo in one field name THEMA_DUARATION_IN_DAYS -> THEMA_DURATION_IN_DAYS
# 1.5 2022-03-16 Massimo Morelli    added qualify to remove duplication caused by trim()
# 1.7 2022-04-27 Massimo Morelli    change THEME_SID to identify the name and not name+theme_start_dt
# 1.8 2022-05-10 Mike Davis         refactor: drive by the scalar t_campaign
#                                   As it stands on 2022-05-10
#                                   :    cmp.campaign_name == cmph.campaign_name
#                                   :    cmp.src_valid_from == cmp.campaign_start_dt
#                                   :    cmp.campaign_start_dt == cmph.campaign_start_dt
#                                   :    cmp.campaign_end_dt != cmph.campaign_end_dt
#                                   :    cmph.dwh_valid_from and cmph.dwh_valid_to and cmph.deleted_fg makes no coherent sense
#                                   Where cmp is P_LEW_CORE.T_CAMPAIGN and cmph is P_LEW_CORE.T_CAMPAIGN_HIST
#                                   So we choose to use P_LEW_CORE.T_CAMPAIGN only but leave the structures in ready
#                                   for P_LEW_CORE.T_CAMPAIGN_HIST to make sense.
#                                   We add a field for hist_promotion_theme_end_dt which can, eventually, be derived
#                                   from P_LEW_CORE.T_CAMPAIGN_HIST but at the moment will be the same as
#                                   promotion_theme_end_dt
# 1.9 2022-05-11 Mike Davis         Change sid for unknown to +ve to reflect that the promotion_theme_sid
#                                   actually exists. We will use the -ve 'Kein Werbethema definiert' if we do
#                                   not find an entry in this view.
#                                   We leave the conditions in here in case we want to change this convention.
#                                   If anything exists in t_campaign (ie. we can join on promotion_theme_sid)
#                                   then we map Null, N/A and unknown to unknown and keep a +ve MD5
#                                   This may change in the future depending upon the business.
# 1.10 2022-05-12 Mike Davis        Convention change:
#                                   'unknown' and 'N/A' now stays as those strings with a +ve MD5
#                                   Null or '' values now changed to 'Kein Werbethema definiert'
#                                   with a calculated sid of (-1000 - client_id)::NUMBER(38,0)
# 1.11 2022-05-16 Mike Davis        Remove collation.
# 1.12 2022-05-17 Mike Davis        Inner join with t_campaign_hist to respect deleted_fg.
#                                   Use historic campaign_name for int_theme (although at the moment
#                                   this always equals campaign_name in t_campaign.
#                                   Keep non-historic and historic start and end dates in:
#                                   PROMOTION_THEME_START_DT
#                                   PROMOTION_THEME_END_DT
#                                   HIST_PROMOTION_THEME_START_DT
#                                   HIST_PROMOTION_THEME_END_DT
# 1.13  2023-03-16 Nikolai Toknov	INT/NAT. Release v.5.15. AP0100400_BS0011293_PIT_REPORTING_ADV_THEMA_NAT/INT - Promotion Impact Tracker - IT-Documentation (itdoc.schwarz) 
# 1.14  2023-09-06 Andreas Kurz 	Changes INT/NAT. Release v.5.15. B-0011293A-AP0186978 Anpassung Mapping INT / NAT aus APT
#									Changed logic for N/A
# 1.15	2024-09-23 Nikolai Toknov	Add schema name for f_CleanString
# 1.16	2024-09-23 Nikolai Toknov	Add schema name for f_CleanValidToDate
#-------------------------------------------------------------------------------
*/

/*
USE ROLE 		R_LDL_D_PIT_ETL;
--USE DATABASE 	LDL_PRODUCTION_CLONE_PIT;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R51501;
USE SCHEMA 		P_LEW_MART_PIT;
USE WAREHOUSE 	WH_LDL_D_PIT_ETL_S;
*/


/* 
---------------------------------------------------------------------
0. Create View Table in V_SOURCE_ADP_ADVERTISEMENT_THEME

Issue: --> will be solved with new APT-Core Release B-0011293A-AP0186978 
COALESCE(pac_active.pvpac_item_campaign_name,pac_active.pvpac_theme_nat,'N/A') as src_item_campaign_name,
COALESCE(pac_active.pvpac_theme_nat,'N/A') as src_theme_nat,
COALESCE(pit.pvpit_pitm_valid_from,TO_DATE('19000101','YYYYMMDD')) as src_valid_from,
COALESCE(pac_active.pvpac_item_campaign_name,pac_active.pvpac_theme_nat) as campaign_name,



------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_PIT.V_SOURCE_ADP_ADVERTISEMENT_THEME
COMMENT = 'Source view on ADP Advertisement Theme (t_campaign, t_campaign_hist)'
AS
SELECT
	  cmp.CLIENT_ID::INTEGER  									                               	AS CLIENT_ID   
	, cmp.CAMPAIGN_SID::INTEGER                                                                 AS CAMPAIGN_SID    --  real PK -- the promotion_theme depends upon the campaign (promotion) and the theme
    
	-- INT ernational Thema indedendend of NF/FA
    , Iff(cmph._CAMPAIGN_NAME IS NULL OR LENGTH(P_LEW_MART_PIT.f_CleanString(cmph._CAMPAIGN_NAME)) = 0 OR P_LEW_MART_PIT.f_CleanString(cmph._CAMPAIGN_NAME) = 'N/A'
          , 'Kein Werbethema definiert (INT)'
          , P_LEW_MART_PIT.f_CleanString(cmph._CAMPAIGN_NAME)
          )::VARCHAR                                         									AS CAMPAIGN_NAME
    , UPPER(CAMPAIGN_NAME)::VARCHAR                                                   			AS CAMPAIGN_NAME_UPPER
	   
	-- NAT national Thema indedendend of NF/FA   
    , Iff(cmp._SRC_THEME_NAT IS NULL OR LENGTH(P_LEW_MART_PIT.f_CleanString(cmp._SRC_THEME_NAT)) =0 OR P_LEW_MART_PIT.f_CleanString(cmp._SRC_THEME_NAT) = 'N/A'
          , 'Kein Werbethema definiert (NAT)'
          , P_LEW_MART_PIT.f_CleanString(cmp._SRC_THEME_NAT)
          )::VARCHAR                                          									AS SRC_THEME_NAME
    , UPPER(SRC_THEME_NAME)                                                            			AS SRC_THEME_NAME_UPPER
       
    , COALESCE(cmp.CAMPAIGN_START_DT, '1900-01-01'::DATE)                                       AS PROMOTION_THEME_START_DT
    , P_LEW_MART_PIT.f_CleanValidToDate(cmp.CAMPAIGN_END_DT)::DATE                                             AS PROMOTION_THEME_END_DT
																								
    -- dates                                                                                    
    , cmph.CAMPAIGN_START_DT::DATE                                        						AS HIST_PROMOTION_THEME_START_DT
    , cmph.CAMPAIGN_END_DT::DATE                                            					AS HIST_PROMOTION_THEME_END_DT

	, MD5(
				--   COALESCE(TO_CHAR(COLLATE( INT_THEME_NAME, 'de-ci-pi-ai-trim' )       ),'') 
				   COALESCE(TO_CHAR(COLLATE(CAMPAIGN_NAME_UPPER, 'de-ci-pi-ai-trim' )  ),'')
				--|| COALESCE(TO_CHAR(COLLATE(NAT_THEME_NAME, 'de-ci-pi-ai-trim' )   		),'') 
				|| COALESCE(TO_CHAR(COLLATE(SRC_THEME_NAME_UPPER, 'de-ci-pi-ai-trim' )	),'')
				|| COALESCE(TO_CHAR(PROMOTION_THEME_START_DT, 'YYYYMMDD' 	),'88881231') 
				|| COALESCE(TO_CHAR(PROMOTION_THEME_END_DT, 'YYYYMMDD'   	),'88881231') 										
			)																					AS SCD_KEY_MD																							
  	, cmph.VALID_FROM_DT                                                                        AS VALID_FROM_DT
	, cmph.VALID_TO_DT                                                                          AS VALID_TO_DT
    , cmph.DELETED_FG                                                                           AS DELETED_FG
    , cmph.DWH_UPDATED_TS																		AS DWH_UPDATED_TS
    , cmph.DWH_CREATED_TS																		AS DWH_CREATED_TS
FROM  
	( 	SELECT 
			  CLIENT_ID 															AS CLIENT_ID
			, CAMPAIGN_SID															AS CAMPAIGN_SID
			, SRC_THEME_NAT 														AS _SRC_THEME_NAT
			, CAMPAIGN_START_DT 													AS CAMPAIGN_START_DT
			, CAMPAIGN_END_DT	 													AS CAMPAIGN_END_DT
		FROM P_LEW_CORE.T_CAMPAIGN 	
	) cmp

	-- Campaing history
	INNER JOIN
	(
		SELECT 
			  CLIENT_ID                                                         	AS CLIENT_ID
			, CAMPAIGN_SID                                                      	AS CAMPAIGN_SID
			, COALESCE( CAMPAIGN_START_DT ,'1900-01-01'::DATE )                 	AS CAMPAIGN_START_DT
			, COALESCE( P_LEW_MART_PIT.f_CleanValidToDate(CAMPAIGN_END_DT),'9999-12-31'::DATE )	AS CAMPAIGN_END_DT
			, CAMPAIGN_NAME 									                	AS _CAMPAIGN_NAME
			, COALESCE( DWH_VALID_FROM,'1900-01-01'::DATE ) 						AS VALID_FROM_DT
			, COALESCE( P_LEW_MART_PIT.f_CleanValidToDate(DWH_VALID_TO),'9999-12-31'::DATE )		AS VALID_TO_DT
			, DWH_UPDATED															AS DWH_UPDATED_TS
			, DWH_CREATED															AS DWH_CREATED_TS
			, DELETED_FG															AS DELETED_FG
		FROM P_LEW_CORE.T_CAMPAIGN_HIST
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
			--AND DELETED_FG	= 0
			--AND CAMPAIGN_SID = 128905
			--AND CAMPAIGN_NAME = 'Technik'

		
		-- Deduplication: take the latest non-deleted record for the campaign_sid
		QUALIFY ROW_NUMBER() OVER(PARTITION BY CLIENT_ID, CAMPAIGN_SID, VALID_FROM_DT ORDER BY DWH_UPDATED DESC) = 1
	) cmph
	ON TRUE
		AND cmp.CLIENT_ID    = cmph.CLIENT_ID
		AND cmp.CAMPAIGN_SID = cmph.CAMPAIGN_SID

WHERE TRUE 
	--AND cmp.CLIENT_ID = 34
	--AND cmp.CAMPAIGN_SID = 311890
;

-- SELECT COUNT(1) FROM P_LEW_MART_PIT.V_SOURCE_ADP_ADVERTISEMENT_THEME WHERE TRUE AND CAMPAIGN_SID < 0  
-- SELECT * FROM P_LEW_MART_PIT.V_SOURCE_ADP_ADVERTISEMENT_THEME WHERE TRUE AND CAMPAIGN_SID 	IN (293837,260183, 307437)
-- SELECT CLIENT_ID, COUNT(1) FROM P_LEW_MART_PIT.V_SOURCE_ADP_ADVERTISEMENT_THEME WHERE TRUE AND PROMOTION_THEME_START_DT IS NULL OR PROMOTION_THEME_START_DT = '1900-01-01'::DATE GROUP BY 1
-- SELECT CLIENT_ID, CAMPAIGN_SID, SCD_KEY_MD,  COUNT(1) FROM P_LEW_MART_PIT.V_SOURCE_ADP_ADVERTISEMENT_THEME WHERE TRUE GROUP BY 1,2,3


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
# 1.2 2021-10-11 Aparna Rayanki 	Added CROSS JOIN with t_campaign and theme_descr column
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
#                                   from LDL.P_LEW_CORE.T_CAMPAIGN_HIST but at the moment will be the same as
#                                   promotion_theme_end_dt
# 1.9 2022-05-11 Mike Davis         Change sid for unknown to +ve to reflect that the promotion_theme_sid
#                                   actually exists. We will use the -ve 'Kein Werbethema definiert' if we do
#                                   not find an entry in this view.
#                                   We leave the conditions in here in case we want to change this convention.
#                                   If anything exists in t_campaign (ie. we can CROSS JOIN on promotion_theme_sid)
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
# 1.13  2023-03-16 Nikolai Toknov	INTEGER /NAT. Release v.5.15. AP0100400_BS0011293_PIT_REPORTING_ADV_THEMA_NAT/INTEGER  - Promotion Impact Tracker - IT-Documentation (itdoc.schwarz) 
# 1.14  2023-09-06 Andreas Kurz 	Changes INTEGER /NAT. Release v.5.15. B-0011293A-AP0186978 Anpassung Mapping INTEGER  / NAT aus APT
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



CREATE OR REPLACE VIEW ldl_p_lew_mart_pit.v_source_adp_advertisement_theme
OPTIONS(DESCRIPTION = `SOURCE VIEW ON ADP ADVERTISEMENT THEME (T_CAMPAIGN, T_CAMPAIGN_HIST)`) AS
-- real PK -- the promotion_theme depends upon the campaign (promotion) and the theme

-- INTEGER ernational Thema indedendend of NF/FA
 -- NAT national Thema indedendend of NF/FA
 -- dates

-- COALESCE(TO_CHAR(COLLATE( INT_THEME_NAME, 'de-ci-pi-ai-trim' )       ),'')

-- || COALESCE(TO_CHAR(COLLATE(NAT_THEME_NAME, 'de-ci-pi-ai-trim' )   		),'')
 -- Campaing history
 -- PIT Country

-- AND DELETED_FG	= 0
 -- AND CAMPAIGN_SID = 128905
 -- AND CAMPAIGN_NAME = 'Technik'

-- Deduplication: take the latest non-deleted record for the campaign_sid
 -- AND cmp.CLIENT_ID = 34

-- AND cmp.CAMPAIGN_SID = 311890
 SELECT CAST(cmp.client_id AS BIGNUMERIC) AS client_id,
 CAST(cmp.campaign_sid AS BIGNUMERIC) AS campaign_sid,
 CAST(IF(cmph.`_campaign_name` IS NULL OR LENGTH(ldl_p_lew_mart_pit.f_cleanstring(COLLATE(cmph.`_campaign_name`,''))) = 0 OR ldl_p_lew_mart_pit.f_cleanstring(COLLATE(cmph.`_campaign_name`,'')) = 'N/A', 'Kein Werbethema definiert (INTEGER )', ldl_p_lew_mart_pit.f_cleanstring(COLLATE(cmph.`_campaign_name`,''))) AS STRING)
 AS campaign_name,
 UPPER(CAST(IF(cmph.`_campaign_name` IS NULL OR LENGTH(ldl_p_lew_mart_pit.f_cleanstring(COLLATE(cmph.`_campaign_name`,''))) = 0 OR ldl_p_lew_mart_pit.f_cleanstring(COLLATE(cmph.`_campaign_name`,'')) = 'N/A', 'Kein Werbethema definiert (INTEGER )', ldl_p_lew_mart_pit.f_cleanstring(COLLATE(cmph.`_campaign_name`,''))) AS STRING)
  ) AS campaign_name_upper,
 CAST(IF(cmp.`_src_theme_nat` IS NULL OR LENGTH(ldl_p_lew_mart_pit.f_cleanstring(COLLATE(cmp.`_src_theme_nat`,''))) = 0 OR ldl_p_lew_mart_pit.f_cleanstring(COLLATE(cmp.`_src_theme_nat`,'')) = 'N/A', 'Kein Werbethema definiert (NAT)', ldl_p_lew_mart_pit.f_cleanstring(COLLATE(cmp.`_src_theme_nat`,''))) AS STRING)
 AS src_theme_name,
 UPPER(CAST(IF(cmp.`_src_theme_nat` IS NULL OR LENGTH(ldl_p_lew_mart_pit.f_cleanstring(COLLATE(cmp.`_src_theme_nat`,''))) = 0 OR ldl_p_lew_mart_pit.f_cleanstring(COLLATE(cmp.`_src_theme_nat`,'')) = 'N/A', 'Kein Werbethema definiert (NAT)', ldl_p_lew_mart_pit.f_cleanstring(COLLATE(cmp.`_src_theme_nat`,''))) AS STRING)
  ) AS src_theme_name_upper,
 COALESCE(cmp.campaign_start_dt, DATE('1900-01-01')) AS promotion_theme_start_dt,
 DATE(ldl_p_lew_mart_pit.f_cleanvalidtodate(cmp.campaign_end_dt)) AS promotion_theme_end_dt,
 DATE(cmph.campaign_start_dt) AS hist_promotion_theme_start_dt,
 DATE(cmph.campaign_end_dt) AS hist_promotion_theme_end_dt,
 TO_HEX(MD5(COALESCE(COLLATE(UPPER(CAST(IF(cmph.`_campaign_name` IS NULL OR LENGTH(ldl_p_lew_mart_pit.f_cleanstring(COLLATE(cmph.`_campaign_name`,''))) = 0 OR ldl_p_lew_mart_pit.f_cleanstring(COLLATE(cmph.`_campaign_name`,'')) = 'N/A', 'Kein Werbethema definiert (INTEGER )', ldl_p_lew_mart_pit.f_cleanstring(COLLATE(cmph.`_campaign_name`,''))) AS
          STRING)), 'de-ci-pi-ai-trim'), '') || COALESCE(COLLATE(UPPER(CAST(IF(cmp.`_src_theme_nat` IS NULL OR LENGTH(ldl_p_lew_mart_pit.f_cleanstring(COLLATE(cmp.`_src_theme_nat`,''))) = 0 OR ldl_p_lew_mart_pit.f_cleanstring(COLLATE(cmp.`_src_theme_nat`,'')) = 'N/A', 'Kein Werbethema definiert (NAT)', ldl_p_lew_mart_pit.f_cleanstring(COLLATE(cmp.`_src_theme_nat`,''))) AS STRING)), 'de-ci-pi-ai-trim'), '') || COALESCE(FORMAT_DATE('%Y%m%d', COALESCE(cmp.campaign_start_dt
        , DATE('1900-01-01'))), '88881231') || COALESCE(FORMAT_DATE('%Y%m%d', DATE(ldl_p_lew_mart_pit.f_cleanvalidtodate(cmp
        .campaign_end_dt))), '88881231'))) AS scd_key_md,
 cmph.valid_from_dt,
 cmph.valid_to_dt,
 cmph.deleted_fg,
 cmph.dwh_updated_ts,
 cmph.dwh_created_ts
FROM (SELECT client_id,
   campaign_sid,
   src_theme_nat AS `_src_theme_nat`,
   campaign_start_dt,
   campaign_end_dt
  FROM ldl_p_lew_core.t_campaign) AS cmp
 INNER JOIN (SELECT client_id,
   campaign_sid,
   COALESCE(campaign_start_dt, DATE('1900-01-01')) AS campaign_start_dt,
   COALESCE(ldl_p_lew_mart_pit.f_cleanvalidtodate(campaign_end_dt), DATE('9999-12-31')) AS campaign_end_dt,
   campaign_name AS `_campaign_name`,
   COALESCE(dwh_valid_from, DATE('1900-01-01')) AS valid_from_dt,
   COALESCE(ldl_p_lew_mart_pit.f_cleanvalidtodate(dwh_valid_to), DATE('9999-12-31')) AS valid_to_dt,
   dwh_updated AS dwh_updated_ts,
   dwh_created AS dwh_created_ts,
   deleted_fg
  FROM ldl_p_lew_core.t_campaign_hist
  WHERE client_id IN (SELECT client_id
     FROM ldl_p_lew_mart_pit.t_dim_client
     WHERE pit_country_fg = 1
      AND deleted_fg = 0
      AND reject_fg = 0
      AND current_fg = 1
     GROUP BY client_id)
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY client_id, campaign_sid, COALESCE(dwh_valid_from, DATE('1900-01-01'))
      ORDER BY dwh_updated IS NULL DESC, dwh_updated DESC)) = 1) AS cmph ON cmp.client_id = cmph.client_id AND cmp.campaign_sid
    = cmph.campaign_sid;


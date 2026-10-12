/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for V_SOURCE_ADP_CAMPAIGN_ITEM_ELEMENT_HIST_1
#-------------------------------------------------------------------------------
# Describtion: Create View for V_SOURCE_ADP_CAMPAIGN_ITEM_ELEMENT_HIST_1
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
# 1.0 2022-02-23 Nikolai Toknov 	Initial version
# 1.1 2022-03-03 Nikolai Toknov  	Add f_CleanValidToDate and T_CNTL_PROCESSING_PARAM_NORMALIZED_1
# 1.2 2022-03-29 Nikolai Toknov		Change CROSS JOIN with t_item_hist_1 
# 1.3 2022-06-30 Nikolai Toknov		Drop "AND DELETED_FG = 0". This is WA for NSR3021858
# 1.4 2023-03-16 Nikolai Toknov		INT/NAT. Release v.5.15. AP0100400_BS0011293_PIT_REPORTING_ADV_THEMA_NAT/INT - Promotion Impact Tracker - IT-Documentation (itdoc.schwarz) 
# 1.5 2023-05-25 Nikolai Toknov	 	Change DWH_VALID_FROM -> VALID_FROM_DT and DWH_VALID_TO -> VALID_TO_DT 
# 1.6 2023-06-09 Nikolai Toknov		Change column name to NAT_THEME_TXT
# 1.7 2023-09-06 Andreas Kurz 		Changes INT/NAT. Release v.5.15. B-0011293A-AP0186978 Anpassung Mapping INT / NAT aus APT
#									Changed logic for N/A
# 1.8 2024-09-23 Nikolai Toknov		Add schema name for f_CleanString
# 1.9 2024-09-23 Nikolai Toknov		Add schema name for f_CleanValidToDate
#-------------------------------------------------------------------------------
*/

/*
USE ROLE 		R_LDL_D_PIT_ETL;
--USE DATABASE 	LDL_PRODUCTION_CLONE_PIT;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R51503;
USE SCHEMA 		P_LEW_MART_PIT_1;
USE WAREHOUSE 	WH_LDL_D_PIT_ETL_S;
*/
/* 
---------------------------------------------------------------------
0. Create View Table in V_SOURCE_ADP_CAMPAIGN_ITEM_ELEMENT_HIST_1
------------------------------------------------------------------------
*/



CREATE OR REPLACE VIEW ldl_p_lew_mart_pit.v_source_adp_campaign_item_element_hist_1 AS SELECT cp.client_id,
 cp.campaign_elem_sid,
 COALESCE(cp.campaign_sid, - 1) AS campaign_sid,
 CAST(IF(cp.nat_theme_txt IS NULL OR LENGTH(ldl_p_lew_mart_pit.f_cleanstring(cp.nat_theme_txt)) = 0 OR ldl_p_lew_mart_pit.f_cleanstring(cp.nat_theme_txt) = 'N/A', 'Kein Werbethema Kategorie definiert (NAT)', ldl_p_lew_mart_pit.f_cleanstring(cp.nat_theme_txt)) AS STRING)
 AS nat_theme_txt,
 CAST(UPPER(IF(cp.nat_theme_txt IS NULL OR LENGTH(ldl_p_lew_mart_pit.f_cleanstring(cp.nat_theme_txt)) = 0 OR ldl_p_lew_mart_pit.f_cleanstring(cp.nat_theme_txt) = 'N/A', 'Kein Werbethema Kategorie definiert (NAT)', ldl_p_lew_mart_pit.f_cleanstring(cp.nat_theme_txt))) AS STRING)
 AS nat_theme_txt_upper,
 cp.item_sid,
 COALESCE(ROUND(SAFE_CAST(itm.src_orig_item_nr AS BIGNUMERIC), 0), ROUND(SAFE_CAST(itm.config_item_cd AS BIGNUMERIC), 0
   ), ROUND(SAFE_CAST(itm.src_matnr AS BIGNUMERIC), 0), - 1) AS orig_item_nr,
 cp.campaign_elem_status_cd,
 COALESCE(cp.campaign_elem_start_dt, PARSE_DATE('%F', '1900-01-01')) AS campaign_elem_start_dt,
 COALESCE(cp.campaign_elem_end_dt, PARSE_DATE('%F', '9999-12-31')) AS real_campaign_elem_end_dt,
 cp.deleted_fg,
 cp.dwh_valid_from AS valid_from_dt,
 COALESCE(ldl_p_lew_mart_pit.f_cleanvalidtodate(cp.dwh_valid_to), DATE('9999-12-31')) AS valid_to_dt
FROM (SELECT *
  FROM ldl_p_lew_core.t_campaign_element_hist_1
  WHERE campaign_elem_status_cd <> 'DRAFT'
   AND client_id IN (SELECT client_id
     FROM ldl_p_lew_mart_pit.t_dim_client_1
     WHERE pit_country_fg = 1
      AND deleted_fg = 0
      AND reject_fg = 0
      AND current_fg = 1
     GROUP BY client_id)
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(campaign_elem_sid AS STRING), dwh_valid_from ORDER BY dwh_updated
        IS NULL DESC, dwh_updated DESC)) = 1) AS cp
 INNER JOIN (SELECT *
  FROM ldl_p_lew_core.t_item_1
  WHERE client_id IN (SELECT client_id
     FROM ldl_p_lew_mart_pit.t_dim_client_1
     WHERE pit_country_fg = 1
      AND deleted_fg = 0
      AND reject_fg = 0
      AND current_fg = 1
     GROUP BY client_id)
   AND (client_id, item_sid) IN (SELECT (client_id, item_sid)
     FROM ldl_p_lew_core.t_item_hist_1
     GROUP BY client_id,
      item_sid)
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(item_sid AS STRING) ORDER BY dwh_updated IS NULL DESC, dwh_updated DESC
      )) = 1) AS itm ON cp.client_id = itm.client_id AND cp.item_sid = itm.item_sid;


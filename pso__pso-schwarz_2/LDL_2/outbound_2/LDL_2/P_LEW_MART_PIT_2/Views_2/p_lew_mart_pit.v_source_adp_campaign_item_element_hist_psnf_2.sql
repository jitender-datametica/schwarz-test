/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for V_SOURCE_ADP_CAMPAIGN_ITEM_ELEMENT_HIST_PSNF_2
#-------------------------------------------------------------------------------
# Describtion: Create View for V_SOURCE_ADP_CAMPAIGN_ITEM_ELEMENT_HIST_PSNF_2
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
# 1.0 2022-02-23 Nikolai Toknov 	Initial version
# 1.1 2022-03-03 Nikolai Toknov  	Add f_CleanValidToDate and T_CNTL_PROCESSING_PARAM_NORMALIZED_2
# 1.2 2022-03-29 Nikolai Toknov		Change CROSS JOIN with t_item_hist_2 
# 1.3 2022-06-30 Nikolai Toknov		Drop "AND DELETED_FG = 0". This is WA for NSR3021858
# 1.4 2023-08-28 Nikolai Toknov		WA: Include all status_2 for psnf
# 1.5 2024-09-23 Nikolai Toknov		Add schema name for f_CleanValidToDate
#-------------------------------------------------------------------------------
*/

/* 
---------------------------------------------------------------------
0. Create View Table in V_SOURCE_ADP_CAMPAIGN_ITEM_ELEMENT_HIST_PSNF_2
------------------------------------------------------------------------
*/



CREATE OR REPLACE VIEW ldl_p_lew_mart_pit.v_source_adp_campaign_item_element_hist_psnf_2 AS SELECT cp.client_id,
 cp.campaign_elem_sid,
 COALESCE(cp.campaign_sid, - 1) AS theme_sid,
 cp.item_sid,
 COALESCE(ROUND(SAFE_CAST(itm.src_orig_item_nr AS BIGNUMERIC), 0), ROUND(SAFE_CAST(itm.config_item_cd AS BIGNUMERIC), 0
   ), ROUND(SAFE_CAST(itm.src_matnr AS BIGNUMERIC), 0), - 1) AS orig_item_nr,
 cp.campaign_elem_status_cd,
 COALESCE(cp.campaign_elem_start_dt, PARSE_DATE('%F', '1900-01-01')) AS campaign_elem_start_dt,
 COALESCE(cp.campaign_elem_end_dt, PARSE_DATE('%F', '9999-12-31')) AS real_campaign_elem_end_dt,
 cp.deleted_fg,
 cp.dwh_valid_from,
 COALESCE(ldl_p_lew_mart_pit.f_cleanvalidtodate(cp.dwh_valid_to), DATE('9999-12-31')) AS dwh_valid_to
FROM (SELECT *
  FROM ldl_p_lew_core.t_campaign_element_hist_2
  WHERE client_id IN (SELECT client_id
     FROM ldl_p_lew_mart_pit.t_dim_client_2
     WHERE pit_country_fg = 1
      AND deleted_fg = 0
      AND reject_fg = 0
      AND current_fg = 1
     GROUP BY client_id)
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(campaign_elem_sid AS STRING), dwh_valid_from ORDER BY dwh_updated
        IS NULL DESC, dwh_updated DESC)) = 1) AS cp
 INNER JOIN (SELECT *
  FROM ldl_p_lew_core.t_item_2
  WHERE client_id IN (SELECT client_id
     FROM ldl_p_lew_mart_pit.t_dim_client_2
     WHERE pit_country_fg = 1
      AND deleted_fg = 0
      AND reject_fg = 0
      AND current_fg = 1
     GROUP BY client_id)
   AND (client_id, item_sid) IN (SELECT (client_id, item_sid)
     FROM ldl_p_lew_core.t_item_hist_2
     GROUP BY client_id,
      item_sid)
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(item_sid AS STRING) ORDER BY dwh_updated IS NULL DESC, dwh_updated DESC
      )) = 1) AS itm ON cp.client_id = itm.client_id AND cp.item_sid = itm.item_sid;


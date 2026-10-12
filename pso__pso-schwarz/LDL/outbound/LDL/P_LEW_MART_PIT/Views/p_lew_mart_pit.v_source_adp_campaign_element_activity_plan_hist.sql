/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for V_SOURCE_ADP_CAMPAIGN_ELEMENT_ACTIVITY_PLAN_HIST
#-------------------------------------------------------------------------------
# Describtion: Create View for V_SOURCE_ADP_CAMPAIGN_ELEMENT_ACTIVITY_PLAN_HIST
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
# 1.0 2022-02-23 Nikolai Toknov  Initial version
# 1.1 2022-03-03 Nikolai Toknov  Add f_CleanValidToDate and T_CNTL_PROCESSING_PARAM_NORMALIZED
# 1.2 2022-03-24 Mike Davis      Add MEDIUM_SID and MEDIUM_DISPLAY_NAME
# 1.3 2022-06-08 Andreas Kurz	 Changed MEDIUM_SID
# 1.4 2022-06-30 Nikolai Toknov  Drop "eph.DELETED_FG = 0". This is WA for NSR3021858
# 1.5 2023-05-25 Nikolai Toknov	 Change DWH_VALID_FROM -> VALID_FROM_DT and DWH_VALID_TO -> VALID_TO_DT 
# 1.6 2024-09-23 Nikolai Toknov	 Add schema name for f_CleanString
# 1.7 2024-09-23 Nikolai Toknov	 Add schema name for f_CleanValidToDate
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT;
USE SCHEMA 		P_LEW_MART_PIT; 
*/

/* 
---------------------------------------------------------------------
0. Create View Table in V_SOURCE_ADP_CAMPAIGN_ELEMENT_ACTIVITY_PLAN_HIST
------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_pit.v_source_adp_campaign_element_activity_plan_hist AS SELECT EPH.client_id,
 EPH.campaign_elem_plan_sid,
 COALESCE(EPH.campaign_elem_sid, - 1) AS campaign_elem_sid,
 EPH.campaign_activity_type_cd,
 EPH.plan_status_cd,
 COALESCE(EPH.price_active_from_dt, PARSE_DATE('%F', '1900-01-01')) AS price_active_from_dt,
 COALESCE(EPH.price_active_to_dt, PARSE_DATE('%F', '9999-12-31')) AS real_price_active_to_dt,
 COALESCE(EPH.sales_channel_sid, - 1000) AS sales_channel_sid,
 EPH.adv_dt,
 COALESCE(EPH.adv_channel_sid, - 1000) AS adv_channel_sid,
 CAST(ldl_p_lew_mart_pit.f_cleanstring("med.adv_channel_name") AS STRING) AS medium_display_name,
 COALESCE(EPH.adv_channel_sid, - 1000) AS medium_sid,
 EPH.deleted_fg,
 EPH.dwh_valid_from AS valid_from_dt,
 ldl_p_lew_mart_pit.f_cleanvalidtodate(EPH.dwh_valid_to) AS valid_to_dt
FROM ldl_p_lew_core.t_campaign_element_activity_plan_hist AS EPH
 LEFT JOIN (SELECT client_id,
   adv_channel_sid,
   adv_channel_name
  FROM ldl_p_lew_core.t_advertisement_channel
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY adv_channel_sid ORDER BY dwh_updated IS NULL DESC, dwh_updated DESC)) = 1) AS
 med ON EPH.client_id = med.client_id AND EPH.adv_channel_sid = med.adv_channel_sid
WHERE EPH.campaign_activity_type_cd IN ('ADV', 'PRC', 'SPL')
 AND EPH.client_id IN (SELECT client_id
   FROM ldl_p_lew_mart_pit.t_dim_client
   WHERE pit_country_fg = 1
    AND deleted_fg = 0
    AND reject_fg = 0
    AND current_fg = 1
   GROUP BY client_id)
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(EPH.campaign_elem_plan_sid AS STRING), EPH.dwh_valid_from ORDER BY EPH.dwh_updated
      IS NULL DESC, EPH.dwh_updated DESC)) = 1;



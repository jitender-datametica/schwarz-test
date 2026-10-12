/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2023
#-------------------------------------------------------------------------------
# Interface : View for V_AGG_REJECT_ISSUE_2
#-------------------------------------------------------------------------------
# Describtion: Create Frontend View for V_AGG_REJECT_ISSUE_2
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2023-07-27 Nikolai Toknov	    Initial version
#  1.1  2025-01-15 Nikolai Toknov		Change for T_AGG_REGION_CENTRAL_NAN_2
#-------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_pit.v_agg_reject_issue_2 (table_name, client_id, adv_week_id, cnt_reject_fg)
OPTIONS(DESCRIPTION = `VIEW V_AGG_REJECT_ISSUE.ANALYSIS OF THE NUMBER OF REJECTIONS IN T_AGG-*TABLES`) AS SELECT
 'T_AGG_REGION_CENTRAL_NAN_2' AS table_name,
 client_id,
 adv_week_id,
 SUM(reject_fg) AS cnt_reject_fg
FROM ldl_p_lew_fe_mstr_pit.t_agg_region_central_nan_2
GROUP BY client_id,
 adv_week_id
HAVING cnt_reject_fg > 0
UNION ALL
SELECT 'T_AGG_REGION_CATEGORY_ALL_2' AS table_name,
 client_id,
 adv_week_id,
 SUM(reject_fg) AS cnt_reject_fg
FROM ldl_p_lew_fe_mstr_pit.t_agg_region_category_all_2
GROUP BY client_id,
 adv_week_id
HAVING cnt_reject_fg > 0
UNION ALL
SELECT 'T_AGG_REGION_MEDIUM_ALL_2' AS table_name,
 client_id,
 adv_week_id,
 SUM(reject_fg) AS cnt_reject_fg
FROM ldl_p_lew_fe_mstr_pit.t_agg_region_medium_all_2
GROUP BY client_id,
 adv_week_id
HAVING cnt_reject_fg > 0
UNION ALL
SELECT 'T_AGG_REGION_PERIOD_ALL_2' AS table_name,
 client_id,
 adv_week_id,
 SUM(reject_fg) AS cnt_reject_fg
FROM ldl_p_lew_fe_mstr_pit.t_agg_region_period_all_2
GROUP BY client_id,
 adv_week_id
HAVING cnt_reject_fg > 0
UNION ALL
SELECT 'T_AGG_REGION_THEME_ALL_2' AS table_name,
 client_id,
 adv_week_id,
 SUM(reject_fg) AS cnt_reject_fg
FROM ldl_p_lew_fe_mstr_pit.t_agg_region_theme_all_2
GROUP BY client_id,
 adv_week_id
HAVING cnt_reject_fg > 0;
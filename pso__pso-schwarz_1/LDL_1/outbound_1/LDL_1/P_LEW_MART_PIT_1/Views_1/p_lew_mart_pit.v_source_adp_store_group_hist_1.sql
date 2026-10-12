/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for V_SOURCE_ADP_STORE_GROUP_HIST_1
#-------------------------------------------------------------------------------
# Describtion: Create View for V_SOURCE_ADP_STORE_GROUP_HIST_1
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
# 1.0 2022-02-23 Nikolai Toknov Initial version
# 1.1 2022-03-03 Nikolai Toknov  Add f_CleanValidToDate and T_CNTL_PROCESSING_PARAM_NORMALIZED_1
# 1.2 2022-03-29 Nikolai Toknov	 CR fix. View doesn't use now.
# 1.3 2023-05-25 Nikolai Toknov	 Change DWH_VALID_FROM -> VALID_FROM_DT and DWH_VALID_TO -> VALID_TO_DT
# 1.4 2024-09-23 Nikolai Toknov	 Add schema name for f_CleanValidToDate
#-------------------------------------------------------------------------------
*/

/* 
---------------------------------------------------------------------
0. Create View Table in V_SOURCE_ADP_STORE_GROUP_HIST_1
------------------------------------------------------------------------
*/




CREATE OR REPLACE VIEW ldl_p_lew_mart_pit.v_source_adp_store_group_hist_1
OPTIONS(DESCRIPTION = `SOURCE VIEW ADP STORE GROUP HISTORY`) AS SELECT client_id,
 store_grp_sid,
 dwh_valid_from AS valid_from_dt,
 COALESCE(ldl_p_lew_mart_pit.f_cleanvalidtodate(dwh_valid_to), DATE('9999-12-31')) AS valid_to_dt
FROM ldl_p_lew_core.t_store_group_hist_1
WHERE UPPER(store_grp_type_cd) = 'CMP'
 AND deleted_fg = 0
 AND client_id IN (SELECT client_id
   FROM ldl_p_lew_mart_pit.t_dim_client_1
   WHERE pit_country_fg = 1
    AND deleted_fg = 0
    AND reject_fg = 0
    AND current_fg = 1
   GROUP BY client_id)
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(store_grp_sid AS STRING), dwh_valid_from ORDER BY dwh_updated IS NULL DESC
      , dwh_updated DESC)) = 1;





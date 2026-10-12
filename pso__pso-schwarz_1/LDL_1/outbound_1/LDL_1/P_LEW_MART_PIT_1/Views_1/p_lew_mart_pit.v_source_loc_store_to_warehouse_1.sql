/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for V_SOURCE_LOC_STORE_TO_WAREHOUSE_1
#-------------------------------------------------------------------------------
# Describtion: Create View for V_SOURCE_LOC_STORE_TO_WAREHOUSE_1
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-02-10 Nikolai Toknov	   Initial version
#  1.1	2024-09-23 Nikolai Toknov	   Add schema name for f_CleanValidToDate
#-------------------------------------------------------------------------------
*/


/* 
---------------------------------------------------------------------
0. Create View Table in V_SOURCE_LOC_STORE_TO_WAREHOUSE_1
------------------------------------------------------------------------
*/



CREATE OR REPLACE VIEW ldl_p_lew_mart_pit.v_source_loc_store_to_warehouse_1
OPTIONS(DESCRIPTION = `SOURCE VIEW STORE_TO_WAREHOUSE`) AS SELECT CAST(client_id AS BIGNUMERIC) AS client_id,
 loc_sid_store AS store_sid,
 loc_sid_wh AS warehouse_sid,
 COALESCE(active_from_dt, PARSE_DATE('%F', '1900-01-01')) AS active_from_dt,
 COALESCE(active_to_dt, PARSE_DATE('%F', '9999-12-31')) AS active_to_dt,
 COALESCE(dwh_valid_from, PARSE_DATE('%F', '1900-01-01')) AS valid_from_dt,
 COALESCE(ldl_p_lew_mart_pit.f_cleanvalidtodate(dwh_valid_to), DATE('9999-12-31')) AS valid_to_dt,
 COALESCE(CAST(deleted_fg AS BIGNUMERIC), 0) AS deleted_fg,
 dwh_updated AS dwh_updated_ts
FROM ldl_p_lew_core.t_store_to_wh_delivery_hist_1
WHERE deleted_fg = 0
 AND item_grp_sid = - 1 * client_id
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(loc_sid_store AS STRING), dwh_valid_from ORDER BY dwh_updated IS NULL DESC
      , dwh_updated DESC)) = 1;



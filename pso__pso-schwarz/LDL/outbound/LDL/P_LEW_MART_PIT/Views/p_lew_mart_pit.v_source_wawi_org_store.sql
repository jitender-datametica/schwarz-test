/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for V_SOURCE_WAWI_ORG_STORE
#-------------------------------------------------------------------------------
# Describtion: Create View for V_SOURCE_WAWI_ORG_STORE
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-07-12 Nikolai Toknov	   Initial version
#  2.0	2022-07-16 Nikolai Toknov  Changing the script for DevOps
#-------------------------------------------------------------------------------
*/

/* 
---------------------------------------------------------------------
0. Create View Table in V_SOURCE_WAWI_ORG_STORE
------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_pit.v_source_wawi_org_store
OPTIONS(DESCRIPTION = `SOURCE VIEW FOR WAWI_ORG_STORE`) AS SELECT st_loc_sid AS store_sid,
 client_id,
 COALESCE(dat_rec_start, PARSE_DATE('%F', '1900-01-01')) AS valid_from_dt,
 COALESCE(dat_rec_end, PARSE_DATE('%F', '9999-12-31')) AS valid_to_dt,
 dat_valid_from,
 closed_fg,
 COALESCE(dat_opening_ovis, PARSE_DATE('%F', '8888-12-31')) AS opening_dt,
 COALESCE(dat_closing_ovis, PARSE_DATE('%F', '8888-12-31')) AS closing_dt
FROM ldl_p_lew_core.t_wawi_org_store;
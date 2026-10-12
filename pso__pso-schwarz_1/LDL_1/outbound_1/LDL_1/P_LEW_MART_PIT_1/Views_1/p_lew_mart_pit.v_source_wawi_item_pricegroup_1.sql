/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2024
#-------------------------------------------------------------------------------
# Interface : View for P_LEW_MART_PIT.V_SOURCE_WAWI_ITEM_PRICEGROUP_1
#-------------------------------------------------------------------------------
# Describtion: Create View for V_SOURCE_WAWI_ITEM_PRICEGROUP_1
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2024-12-09 Nikolai Toknov		Initial version
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R60001; -- new Clone
USE SCHEMA 		P_LEW_MART_PIT_1;
 */
/* 
---------------------------------------------------------------------
0. Create View Table in V_SOURCE_WAWI_ITEM_PRICEGROUP_1
------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_pit.v_source_wawi_item_pricegroup_1 AS SELECT client_id,
 pricegroup_id,
 COALESCE(TRIM(pricegroup_desc), 'n/A') AS pricegroup_desc,
 COALESCE(priority, - 1) AS pricegroup_priority,
 COALESCE(st_loc_sid, - 2) AS store_sid,
 COALESCE(wh_loc_sid, - 2) AS warehouse_sid,
 dat_valid_from,
 dat_valid_until,
 language_id,
 load_id
FROM ldl_p_lew_core.t_wawi_itm_pricegroup_1;
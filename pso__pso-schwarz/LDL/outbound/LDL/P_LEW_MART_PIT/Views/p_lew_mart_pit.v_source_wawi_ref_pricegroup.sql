/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2024
#-------------------------------------------------------------------------------
# Interface : View for P_LEW_MART_PIT.V_SOURCE_WAWI_REF_PRICEGROUP
#-------------------------------------------------------------------------------
# Describtion: Create View for V_SOURCE_WAWI_REF_PRICEGROUP
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
USE SCHEMA 		P_LEW_MART_PIT;
 */
/* 
---------------------------------------------------------------------
0. Create View Table in V_SOURCE_WAWI_REF_PRICEGROUP
------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_pit.v_source_wawi_ref_pricegroup AS SELECT client_id,
 position_article_sales_rep AS pricegroup_priority,
 pricegroup_id,
 pricegroup_desc,
 article_sales_rep_desc,
 dat_valid_from,
 dat_valid_until,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_pricegrp;
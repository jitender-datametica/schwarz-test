/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for DIM_BRAND_NAME
#-------------------------------------------------------------------------------
# Describtion: Create View for Calendar_1 Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2023-11-02 Andreas Kurz	    Initial version
#									Necessary for MSTR Lookup CROSS JOIN
#  1.1  2025-01-15 Nikolai Toknov	Change view (only T_AGG_REGION_CENTRAL_NAN_1)
#-------------------------------------------------------------------------------
*/

/*

USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
--USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R51501;
USE DATABASE	LDL_PRODUCTION_CLONE_PIT_QS;
--USE DATABASE 	LDL_PRODUCTION_CLONE_PIT;
--USE DATABASE	LDL_PRODUCTION_CLONE_PIT_CLONE_AP0123442_AKTIONSTYPEN;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 


*/

/* 
---------------------------------------------------------------------
Create Access View <DB_NAME>.<SCHEMA>.V_<TABLENAME> Current Status_1
------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_pit.v_dim_brand_name_1 OPTIONS(DESCRIPTION = `VIEW DIMENSION BRAND_1 NAME`) AS
SELECT brand_name
FROM (SELECT brand_name
   FROM ldl_p_lew_fe_mstr_pit.t_agg_region_central_nan_1
   WHERE deleted_fg = 0
    AND reject_fg = 0
   GROUP BY brand_name
   UNION ALL
   SELECT 'N/A' AS brand_name) AS t4
GROUP BY brand_name;
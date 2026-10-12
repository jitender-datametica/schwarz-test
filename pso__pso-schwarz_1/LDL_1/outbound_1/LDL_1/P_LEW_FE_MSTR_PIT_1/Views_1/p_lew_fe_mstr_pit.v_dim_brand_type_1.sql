/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for DIM_BRAND_TYPE
#-------------------------------------------------------------------------------
# Describtion: Create View for Calendar_1 Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2023-11-02 Andreas Kurz	    Initial version
#									Necessary for MSTR Lookup CROSS JOIN
#-------------------------------------------------------------------------------
*/

/*

USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R51501;
--USE DATABASE 	LDL_PRODUCTION_CLONE_PIT;
--USE DATABASE	LDL_PRODUCTION_CLONE_PIT_CLONE_AP0123442_AKTIONSTYPEN;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 

*/

/* 
---------------------------------------------------------------------
Create Access View <DB_NAME>.<SCHEMA>.V_<TABLENAME> Current Status_1
------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_pit.v_dim_brand_type_1 OPTIONS(DESCRIPTION = `VIEW DIMENSION ACTION TYPE`) AS
SELECT 'N/A' AS brand_type_cd,
 'Not Applicable' AS brand_type_cd_desc
FROM (SELECT 'N/A' AS column1,
    'Not Applicable' AS column2
   UNION ALL
   SELECT 'M' AS column1,
    'Marke' AS column2
   UNION ALL
   SELECT 'EM' AS column1,
    'Eigenmarke' AS column2);
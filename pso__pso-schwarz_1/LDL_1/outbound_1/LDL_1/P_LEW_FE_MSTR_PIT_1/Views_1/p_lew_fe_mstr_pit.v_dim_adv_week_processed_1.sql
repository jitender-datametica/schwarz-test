/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for DIM_ADV_WEEK
#-------------------------------------------------------------------------------
# Describtion: Create View for Calendar_1 Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz	    Initial version
#  1.1 	2022-03-21 Andreas Kurz		Added furtehr columns to view
#  1.2 	2022-03-21 Dirk Hering		Restricted on closed, processed adv weeks
#  2.0	2022-07-16 Nikolai Toknov   Changing the script for DevOps
#  2.1 	2022-07-18 Dirk Hering		View changed to P_LEW_FE_MSTR_PIT.V_DIM_ADV_WEEK_PROCESSED_1
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#  4.1  2025-09-16 Andreas Kurz		Adding Cube Loading FG and Cube Start/End Adv Weeks
#  4.2  2025-11-19 Nikolai Toknov	Fix prod issue. NEOPIT-250 [ISSUE] Falling load process if parameters are created for the future.
#-------------------------------------------------------------------------------
*/

/*

USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
--USE DATABASE 	LDL_PRODUCTION_CLONE_PIT;
--USE DATABASE	LDL_PRODUCTION_CLONE_PIT_CLONE_AP0123442_AKTIONSTYPEN;
USE DATABASE LDL_QUALITY_CLONE_PIT_PROD;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 

--SHOW DATABASES LIKE 'LDL_PRODUCTION_CLONE_PIT%';
*/

/*
---------------------------------------------------------------------
0. Create View Table in V_DIM_ADV_WEEK_PROCESSED_1
------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_pit.v_dim_adv_week_processed_1
OPTIONS(DESCRIPTION = `VIEW ONLY ON PROCESSED, CLOSED ADVERTISING WEEKS`) AS SELECT *
FROM ldl_p_lew_fe_mstr_pit.v_dim_adv_week_1 AS ADVW
WHERE processed_adv_week_fg = 1
 AND deleted_fg = 0
 AND reject_fg = 0
QUALIFY (ROW_NUMBER() OVER (PARTITION BY client_id, adv_week_id ORDER BY dwh_created_ts IS NULL DESC, dwh_created_ts
      DESC)) = 1;
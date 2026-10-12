/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for DIM_ACTION_TYPE
#-------------------------------------------------------------------------------
# Describtion: Create View for Calendar_1 Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-12-20 Andreas Kurz	    Initial version
#-------------------------------------------------------------------------------
*/

/*

USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R60001;
--USE DATABASE	LDL_PRODUCTION_CLONE_PIT_CLONE_AP0123442_AKTIONSTYPEN;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 

-- LDL_PRODUCTION_CLONE_PIT_CLONE_AP0123442_AKTIONSTYPEN.P_LEW_FE_MSTR_PIT
--SHOW DATABASES LIKE 'LDL_PRODUCTION_CLONE_PIT%';
--SELECT GET_DDL('view','P_LEW_FE_MSTR_PIT.V_DIM_ACTION_TYPE_1');
*/

/* 
---------------------------------------------------------------------
Create Access View <DB_NAME>.<SCHEMA>.V_<TABLENAME> Current Status_1
------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_pit.v_dim_action_type_1 OPTIONS(DESCRIPTION = `VIEW DIMENSION ACTION TYPE`) AS
SELECT action_type_id,
 fe_mstr_relevant_fg,
 action_type_sort_val,
 action_type_name,
 action_type_descr,
 valid_from_dt,
 valid_to_dt,
 version_nr,
 current_fg,
 reject_fg,
 reject_reason_id,
 deleted_fg,
 dwh_created_ts,
 dwh_updated_ts,
 load_id
FROM ldl_p_lew_mart_pit.t_dim_action_type_1 AS TYP
WHERE action_type_id IN (2, 3, 11, 12, - 1000, - 2000)
 AND deleted_fg = 0
 AND reject_fg = 0
 AND current_fg = 1
QUALIFY version_nr = (MAX(version_nr) OVER (PARTITION BY action_type_id RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING));
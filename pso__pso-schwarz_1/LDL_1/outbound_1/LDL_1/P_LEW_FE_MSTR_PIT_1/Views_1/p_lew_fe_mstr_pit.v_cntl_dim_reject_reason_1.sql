/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for CNTL_DIM_REJECT_REASON
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
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT;
USE DATABASE	LDL_PRODUCTION_CLONE_PIT_CLONE_AP0123442_AKTIONSTYPEN;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 

SHOW DATABASES LIKE 'LDL_PRODUCTION_CLONE_PIT%';
*/

/* 
---------------------------------------------------------------------
Create Access View <DB_NAME>.<SCHEMA>.V_<TABLENAME> Current Status_1
------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_pit.v_cntl_dim_reject_reason_1
OPTIONS(DESCRIPTION = `VIEW CONTROL REJECT REASON CODES FOR DQ-DASHBOARD`) AS SELECT reject_reason_id,
 reject_reason_descr,
 valid_from_dt,
 valid_to_dt,
 version_nr,
 current_fg,
 source_system_id,
 deleted_fg,
 dwh_created_ts,
 dwh_updated_ts,
 load_id
FROM ldl_p_lew_mart_pit.t_cntl_dim_reject_reason_1 AS REJ
WHERE deleted_fg = 0
 AND current_fg = 1
QUALIFY version_nr = (MAX(version_nr) OVER (PARTITION BY reject_reason_id RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING));
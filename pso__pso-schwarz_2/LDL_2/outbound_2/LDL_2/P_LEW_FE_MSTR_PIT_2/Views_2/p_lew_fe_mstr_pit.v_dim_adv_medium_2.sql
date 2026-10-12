/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : VIEW for DIM_ADV_MEDIUM
#-------------------------------------------------------------------------------
# Description: Create DDL for view V_DIM_ADV_MEDIUM_2
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-05-18 Mike Davis    	Initial version
#  2.0	2022-07-16 Nikolai Toknov  	Changing the script for DevOps
#  2.1	2022-07-18 Andreas Kurz		Reworked structure 
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/

/*
VC:
MEDIUM_NAME_UPPER
MEDIUM_MSTR_SID
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT;
USE SCHEMA 		P_LEW_MART_PIT_2; 


SELECT '>>> ${EXEC_PIT_TIMESTAMP}  Creating View [V_CNTL_ETL_PERFORMANCE_2] ' AS ""


SELECT get_ddl('table','P_LEW_MART_PIT.T_DIM_ADV_MEDIUM_2');

DROP VIEW LDL.P_LEW_MART_PIT.V_DIM_ADV_MEDIUM_2

*/


CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_pit.v_dim_adv_medium_2
OPTIONS(DESCRIPTION = `VIEW ON ADVERTISING MEDIUM (ONLY VALID RECORDS)`) AS SELECT client_id,
 country_iso_cd,
 country_descr,
 medium_name,
 UPPER(medium_name) AS medium_name_upper,
 medium_name_ldescr,
 medium_sid,
 IF(medium_sid < 0, medium_sid * 100 - client_id, medium_sid * 100 + client_id) AS medium_mstr_sid,
 medium_sort_val,
 missing_medium_fg,
 valid_from_dt,
 valid_to_dt,
 version_nr,
 current_fg,
 reject_fg,
 reject_reason_id,
 source_system_id,
 deleted_fg,
 dwh_created_ts,
 dwh_updated_ts,
 load_id
FROM ldl_p_lew_mart_pit.t_dim_adv_medium_2
WHERE reject_fg = 0
 AND deleted_fg = 0;
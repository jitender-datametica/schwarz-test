/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for PIT_VERSION_INFO
#-------------------------------------------------------------------------------
# Describtion: Create View for Calendar Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-04-21 Prasanna Ranjan	Initial version
#  2.0	2022-07-16 Nikolai Toknov  	Changing the script for DevOps
#  2.1	2022-07-18 Andreas Kurz		Reworked structure 
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R60001;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 


SELECT get_ddl('table','P_LEW_FE_MSTR_PIT.T_DIM_VERSION_INFO');

DESC TABLE P_LEW_FE_MSTR_PIT.T_DIM_VERSION_INFO;
           

DROP VIEW LDL.P_LEW_FE_MSTR_PIT.V_DIM_VERSION_INFO

*/

/* 
---------------------------------------------------------------------
0. Create View Table in V_PIT_VERSION_INFO
------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_pit.v_dim_version_info
OPTIONS(DESCRIPTION = `VIEW TABLE PIT VERSIONING HISTORY / INFO`) AS SELECT version_dt,
 major_nbr,
 minor_nbr,
 build_nbr,
 revision_nbr,
 pit_environment_descr,
 IF(pit_environment_descr = 'TD', 'Teradata 16.20', 'Snowflake') AS pit_environment_long_descr,
 version_info_descr,
       TRIM(CAST(major_nbr AS STRING FORMAT '09')) || '.' || TRIM(CAST(minor_nbr AS STRING FORMAT '09')) || '.' || TRIM(CAST(build_nbr
      AS STRING FORMAT '09')) || '.' || TRIM(CAST(revision_nbr AS STRING FORMAT '09')) AS version_nbr_descr,
     version_info_descr || ' [' || (TRIM(CAST(major_nbr AS STRING FORMAT '09')) || '.' || TRIM(CAST(minor_nbr AS STRING FORMAT '09')
           ) || '.' || TRIM(CAST(build_nbr AS STRING FORMAT '09')) || '.' || TRIM(CAST(revision_nbr AS STRING FORMAT '09')
       )) || '] - ' || FORMAT_DATE('%F', version_dt) AS version_info_long_descr,
 fe_mstr_relevant_fg,
 current_pit_version_fg,
 current_pit_verion_fg,
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
FROM ldl_p_lew_fe_mstr_pit.t_dim_version_info AS INF
WHERE deleted_fg = 0
 AND reject_fg = 0
 AND current_fg = 1
 AND fe_mstr_relevant_fg = 1
 AND current_pit_version_fg = 1;
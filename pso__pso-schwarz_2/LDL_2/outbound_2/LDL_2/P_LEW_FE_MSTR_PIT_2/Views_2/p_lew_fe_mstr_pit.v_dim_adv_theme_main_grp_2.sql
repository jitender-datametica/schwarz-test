/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : VIEW for DIM_ADV_THEME_GRP
#-------------------------------------------------------------------------------
# Description: Create DDL for view V_DIM_ADV_THEME_GRP
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-05-18 Mike Davis    	Initial version
#  1.1  2022-06-22 Andreas Kurz	 	Reworked Structure
#  2.0	2022-07-16 Nikolai Toknov  	Changing the script for DevOps
#  2.1	2022-07-18 Andreas Kurz		Reworked structure 
#  2.2	2022-08-11 Nikolai Toknov	Change for Theme 
#  2.3	2023-02-02 Nikolai Toknov	Fix issue from last commit.
#  2.4  2023-07-28 Nikolai Toknov	Rollback WA
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R51501;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 


SELECT get_ddl('table','P_LEW_MART_PIT.T_DIM_ADV_THEME_GRP');

DESC TABLE P_LEW_MART_PIT.T_DIM_ADV_THEME_GRP;

DROP VIEW LDL.P_LEW_MART_PIT.V_DIM_ADV_THEME_GRP

*/


/*
---------------------------------------------------------------------
0. Create DIM View in V_DIM_ADV_THEME_MAIN_GRP_2
------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_pit.v_dim_adv_theme_main_grp_2 (client_id, country_iso_cd, country_descr,
theme_grp_type_id, theme_grp_type_name, theme_grp_main_mstr_sid, theme_grp_main_name, theme_grp_main_name_upper,
valid_from_dt, valid_to_dt, version_nr, current_fg) OPTIONS(DESCRIPTION = `AS-IS VIEW ON T_DIM_ADV_THEME_MAIN_GRP`) AS
SELECT CAST(client_id AS BIGNUMERIC) AS client_id,
 CAST(country_iso_cd AS STRING) AS country_iso_cd,
 CAST(country_descr AS STRING) AS country_descr,
 CAST(theme_grp_type_id AS BIGNUMERIC) AS theme_grp_type_id,
 CAST(theme_grp_type_name AS STRING) AS theme_grp_type_name,
 theme_grp_main_mstr_sid,
 CAST(theme_grp_main_name AS STRING) AS theme_grp_main_name,
 UPPER(TRIM(theme_grp_main_name)) AS theme_grp_main_name_upper,
 PARSE_DATE('%F', '1900-01-01') AS valid_from_dt,
 PARSE_DATE('%F', '9999-12-31') AS valid_to_dt,
 0 AS version_nr,
 1 AS current_fg
FROM ldl_p_lew_fe_mstr_pit.t_agg_region_theme_all_2
WHERE reject_fg = 0
 AND deleted_fg = 0
GROUP BY client_id,
 country_iso_cd,
 country_descr,
 theme_grp_type_id,
 theme_grp_type_name,
 theme_grp_main_mstr_sid,
 t_agg_region_theme_all.theme_grp_main_name;
/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for DIM_CLIENT
#-------------------------------------------------------------------------------
# Describtion: Create View for Calendar_2 Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-12-20 Andreas Kurz	    Initial version
#  1.1	2023-02-21 Andreas Kurz		Added PIT_COUNTRY_FG = 1 filter
#  1.2	2024-01-04 Andreas Kurz		Added Language_ID column  
#-------------------------------------------------------------------------------
*/

/*

USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
--USE DATABASE 	LDL_PRODUCTION_CLONE_PIT;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R51501;
--USE DATABASE	LDL_PRODUCTION_CLONE_PIT_CLONE_AP0123442_AKTIONSTYPEN;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 

--SHOW DATABASES LIKE 'LDL_PRODUCTION_CLONE_PIT%';
*/

/* 
---------------------------------------------------------------------
Create Access View <DB_NAME>.<SCHEMA>.V_<TABLENAME> Current Status_2
------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_pit.v_dim_client_2 OPTIONS(DESCRIPTION = `VIEW ON CLIENT TABLE`) AS SELECT
DISTINCT CL.client_id,
 CL.country_iso_cd,
 CL.country_descr,
 CL.country_orig_descr,
 CL.country_nat_descr,
 CL.country_int_descr,
 CL.lang_sid,
 CL.client_id AS language_id,
 CL.curr_sid,
 CL.curr_cd,
 CL.exchange_rate_to_eur,
 CL.ctr_adv_week_start_weekday_id,
 COALESCE(CAL.day_of_week_ldesc, 'n/A') AS day_of_week_ldesc,
 CL.ctr_store_nbr,
 CL.ctr_ex_elvis_country_fg,
 CL.ctr_ex_elvis_country_migration_date_from,
 CL.ctr_ex_elvis_country_migration_date_to,
 CL.pit_country_fg,
 CL.valid_from_dt,
 CL.valid_to_dt,
 CL.version_nr,
 CL.current_fg,
 CL.reject_fg,
 CL.reject_reason_id,
 CL.source_system_id,
 CL.deleted_fg,
 CL.dwh_created_ts,
 CL.dwh_updated_ts,
 CL.load_id
FROM ldl_p_lew_mart_pit.t_dim_client_2 AS CL
 INNER JOIN ldl_p_lew_mart_pit.t_dim_calendar_2 AS CAL ON CL.ctr_adv_week_start_weekday_id = CAL.day_of_week_id
WHERE CL.deleted_fg = 0
 AND CL.reject_fg = 0
 AND CL.current_fg = 1
 AND CL.pit_country_fg = 1
QUALIFY CL.version_nr = (MAX(CL.version_nr) OVER (PARTITION BY CL.client_id RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING));
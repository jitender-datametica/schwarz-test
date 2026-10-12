/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2024
#-------------------------------------------------------------------------------
# Interface : View for V_CNTL_ETL_LOGGING
#-------------------------------------------------------------------------------
# Describtion: Create View for V_CNTL_ETL_LOGGING
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2024-04-18 Nikolai Toknov	    Initial version. Task DDLvsGIT. Created the file based on the object in PROD.
#  1.1	2025-01-08 Andreas Kurz			Reworked based on R60001
#-------------------------------------------------------------------------------
*/

/* 
---------------------------------------------------------------------
0. Create View Table in V_CNTL_ETL_LOGGING
------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_pit.v_cntl_etl_logging (run_id_seq, run_ts_char, run_day_id_char, run_ts,
run_day_id, run_clustering_desc, client_id, multi_client_run_lst, multi_client_run_lst_nr, multi_client_run_lst_descr,
multi_client_run_fg, application_name, module_name, component_name, start_run_ts, end_run_ts, run_time_min, run_time_sec
, query_tag, sf_user, sf_warehouse, sf_role, sf_database, sf_schema, sf_session, sf_client, record_processed_nr,
start_processing_fg, end_processing_fg, module_level_fg, component_level_fg, completed_run_fg, deleted_fg,
dwh_created_ts, dwh_updated_ts, load_id, moving_run_id_from_current)
OPTIONS(DESCRIPTION = `ACCESS VIEW KONTROLL ETL LOGGING`) AS SELECT run_id_seq,
 FORMAT_DATETIME('%F %H:%M:%E3S', run_ts) AS run_ts_char,
 FORMAT_DATE('%F', run_day_id) AS run_day_id_char,
 run_ts,
 run_day_id,
 run_clustering_desc,
 client_id,
 multi_client_run_lst,
 CAST(ARRAY_LENGTH(multi_client_run_lst) AS BIGNUMERIC) AS multi_client_run_lst_nr,
 ARRAY_TO_STRING(multi_client_run_lst, ',') AS multi_client_run_lst_descr,
 CAST(IF(SAFE_CAST(ARRAY_LENGTH(multi_client_run_lst) as BIGNUMERIC) > 1, 1, 0) AS BIGNUMERIC) AS multi_client_run_fg,
 application_name,
 module_name,
 component_name,
 FORMAT_DATETIME('%F %H:%M:%S', start_run_ts) AS start_run_ts,
 FORMAT_DATETIME('%F %H:%M:%S', end_run_ts) AS end_run_ts,
 TIMESTAMP_DIFF(end_run_ts, start_run_ts, MINUTE) AS run_time_min,
 TIMESTAMP_DIFF(end_run_ts, start_run_ts, SECOND) AS run_time_sec,
 query_tag,
 sf_user,
 sf_warehouse,
 sf_role,
 sf_database,
 sf_schema,
 sf_session,
 sf_client,
 record_processed_nr,
 start_processing_fg,
 end_processing_fg,
 module_level_fg,
 component_level_fg,
 completed_run_fg,
 deleted_fg,
 dwh_created_ts,
 dwh_updated_ts,
 load_id,
   ((DENSE_RANK() OVER (ORDER BY run_id_seq IS NULL DESC, run_id_seq DESC)) - 1) * - 1 AS moving_run_id_from_current
FROM ldl_p_lew_mart_pit.t_cntl_etl_logging AS LG
WHERE deleted_fg = 0;

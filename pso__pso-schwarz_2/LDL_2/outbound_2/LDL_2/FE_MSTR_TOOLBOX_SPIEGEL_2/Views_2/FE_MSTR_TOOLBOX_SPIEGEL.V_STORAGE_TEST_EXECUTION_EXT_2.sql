/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_TOOLBOX_SPIEGEL.V_STORAGE_TEST_EXECUTION_EXT_2
#----------------------------------------------------------------------------
# History:
#  1.0  28.09.2023    Aparna Rayanki           Initial Version 
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_storage_test_execution_ext_2 (client_id, storage_test_exec_sid,
storage_test_exec_name, end_week, display_end_week, dur_week_cnt, min_training_day_cnt, spread_pct, test_name,
test_week_duration, test_status, filter_display_end_week) AS SELECT client_id,
 storage_test_exec_sid,
 storage_test_exec_name,
 end_week,
 display_end_week,
 dur_week_cnt,
 min_training_day_cnt,
 spread_pct,
 test_name,
 test_week_duration,
 test_status,
 filter_display_end_week
FROM ldl_fe_mstr_toolbox_spiegel.t_storage_test_execution_ext_2;
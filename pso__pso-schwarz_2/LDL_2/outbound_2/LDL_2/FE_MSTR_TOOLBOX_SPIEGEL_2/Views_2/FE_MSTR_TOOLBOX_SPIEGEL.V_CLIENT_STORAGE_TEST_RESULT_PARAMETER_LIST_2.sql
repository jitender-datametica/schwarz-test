/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_TOOLBOX_SPIEGEL.V_CLIENT_STORAGE_TEST_RESULT_PARAMETER_LIST_2
#----------------------------------------------------------------------------
# History:
#  1.0  28.09.2023    Aparna Rayanki           Initial Version 
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_client_storage_test_result_parameter_list_2 (client_id,
storage_test_exec_sid, orig_store_nr, reconstructin_week_list, excluded_week_list) AS SELECT client_id,
 storage_test_exec_sid,
 orig_store_nr,
 reconstructin_week_list,
 excluded_week_list
FROM ldl_fe_mstr_toolbox_spiegel.t_client_storage_test_result_parameter_list_2;
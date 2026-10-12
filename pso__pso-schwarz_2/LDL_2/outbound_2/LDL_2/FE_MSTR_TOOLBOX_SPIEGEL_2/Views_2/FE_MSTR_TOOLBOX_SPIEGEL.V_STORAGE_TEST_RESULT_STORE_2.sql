/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_TOOLBOX_SPIEGEL.V_STORAGE_TEST_RESULT_STORE_2
#----------------------------------------------------------------------------
# History:
#  1.0  28.11.2023    Aparna Rayanki           Initial Version
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_storage_test_result_store_2 (storage_test_exec_sid, orig_store_nr,
store_desc) AS SELECT storage_test_exec_sid,
 orig_store_nr,
 store_desc
FROM ldl_fe_mstr_toolbox_spiegel.t_storage_test_result_store_2;
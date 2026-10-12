/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_TOOLBOX_SPIEGEL.V_STORAGE_TEST_RESULT_MISSING_STORE_1
#----------------------------------------------------------------------------
# History:
#  1.0  28.09.2023    Aparna Rayanki           Initial Version
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_storage_test_result_missing_store_1 (storage_test_exec_sid,
storage_test_result_grp_sid, storage_test_result_grp_type_cd, test_week, reason_descr, user_defined_grp_name) AS SELECT
 storage_test_exec_sid,
 storage_test_result_grp_sid,
 storage_test_result_grp_type_cd,
 test_week,
 reason_descr,
 user_defined_grp_name
FROM ldl_fe_mstr_toolbox_spiegel.t_storage_test_result_missing_store_1;
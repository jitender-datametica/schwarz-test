/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_TOOLBOX_SPIEGEL.V_AGG_STORAGE_TEST_RESULT_STORES_CNT
#----------------------------------------------------------------------------
# History:
#  1.0  28.09.2023    Aparna Rayanki           Initial Version
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_agg_storage_test_result_stores_cnt (storage_test_exec_sid,
storage_test_result_grp_sid, storage_test_result_grp_type_cd, test_week, stores_cnt) AS SELECT storage_test_exec_sid,
 storage_test_result_grp_sid,
 storage_test_result_grp_type_cd,
 test_week,
 stores_cnt
FROM ldl_fe_mstr_toolbox_spiegel.t_agg_storage_test_result_stores_cnt;
/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_TOOLBOX_SPIEGEL.V_AGG_STORAGE_TEST_RESULT_STORES_CNT_2
#----------------------------------------------------------------------------
# History:
#  1.0  28.09.2023    Aparna Rayanki           Initial Version
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_mat_agg_storage_test_result_stores_cnt_2 (storage_test_exec_sid,
storage_test_result_grp_sid, storage_test_result_grp_type_cd, test_week, stores_cnt) AS SELECT storage_test_exec_sid,
 storage_test_result_grp_sid,
 storage_test_result_grp_type_cd,
 test_week,
 `Test_Store_Cnt` AS stores_cnt
FROM (SELECT TR.storage_test_exec_sid,
   TR.storage_test_result_grp_sid,
   GRP.storage_test_result_grp_type_cd,
   GRP.test_week,
   TR.storage_test_param_type_cd,
   TR.param_meas
  FROM ldl_p_lew_core.t_storage_test_parameter_2 AS TR
   INNER JOIN ldl_p_lew_core.t_storage_test_result_group_2 AS GRP ON TR.storage_test_result_grp_sid = GRP.storage_test_result_grp_sid
    
  WHERE TR.storage_test_param_type_cd IN ('Test_Store_Cnt')
   AND UPPER(GRP.storage_test_result_grp_type_cd) = UPPER('General')) PIVOT (SUM(param_meas) FOR
   STORAGE_TEST_PARAM_TYPE_CD IN ('Test_Store_Cnt')) AS pvt1;

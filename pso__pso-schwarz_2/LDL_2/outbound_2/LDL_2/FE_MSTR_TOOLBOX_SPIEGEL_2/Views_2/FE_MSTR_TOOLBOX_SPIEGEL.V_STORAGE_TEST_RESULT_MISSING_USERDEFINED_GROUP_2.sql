/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_TOOLBOX_SPIEGEL.V_STORAGE_TEST_RESULT_MISSING_USERDEFINED_GROUP_2
#----------------------------------------------------------------------------
# History:
#  1.0  28.09.2023    Aparna Rayanki           Initial Version
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_storage_test_result_missing_userdefined_group_2 (storage_test_exec_sid
, storage_test_result_grp_sid, storage_test_result_grp_type_cd, reason_descr, user_defined_grp_name) AS SELECT TR.storage_test_exec_sid
 ,
 TR.storage_test_result_grp_sid,
 grp.storage_test_result_grp_type_cd,
 TR.reason_descr,
 grp.user_defined_grp_name
FROM ldl_p_lew_core.t_storage_test_missing_result_2 AS TR
 INNER JOIN (SELECT storage_test_result_grp_sid,
   storage_test_result_grp_type_cd,
   test_week,
   user_defined_grp_name
  FROM ldl_p_lew_core.t_storage_test_result_group_2 AS GRP
  WHERE UPPER(storage_test_result_grp_type_cd) = UPPER('UserDefinedGroup')
   AND test_week = - 1
  GROUP BY storage_test_result_grp_sid,
   storage_test_result_grp_type_cd,
   test_week,
   user_defined_grp_name) AS grp ON TR.storage_test_result_grp_sid = grp.storage_test_result_grp_sid
WHERE TR.storage_test_metric_type_cd = '-';
/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_TOOLBOX_SPIEGEL.V_STORAGE_TEST_RESULT_STORE_1
#----------------------------------------------------------------------------
# History:
#  1.0  28.11.2023    Aparna Rayanki           Initial Version
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_mat_storage_test_result_store_1 (storage_test_exec_sid, orig_store_nr
, store_desc) AS SELECT TR.storage_test_exec_sid,
 LOC.src_orig_store_nr AS orig_store_nr,
 LOC.loc_name AS store_desc
FROM ldl_p_lew_core.t_storage_test_result_1 AS TR
 INNER JOIN ldl_p_lew_core.t_storage_test_result_group_1 AS GRP ON TR.storage_test_result_grp_sid = GRP.storage_test_result_grp_sid
  
 INNER JOIN ldl_p_lew_core.t_storage_test_execution_1 AS EXT ON TR.storage_test_exec_sid = EXT.storage_test_exec_sid
 INNER JOIN ldl_p_lew_core.t_location_1 AS LOC ON EXT.client_id = LOC.client_id AND GRP.loc_sid_store = LOC.loc_sid
WHERE UPPER(GRP.storage_test_result_grp_type_cd) = UPPER('Store')
GROUP BY TR.storage_test_exec_sid,
 orig_store_nr,
 store_desc;